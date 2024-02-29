

import 'dart:io';

import 'package:clone/models/reply_model.dart';
import 'package:clone/services/navigation_service.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/env.dart';
import 'package:clone/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';
class ThreadController extends GetxController{
  final TextEditingController textEditingController = TextEditingController(text: "");
  var content = "".obs;
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var showThreadLoading = false.obs;
  Rx<PostModel> post = Rx<PostModel>(PostModel());
  var showReplyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();


  void pickImage()async{
    File? file = await pickImageFromGallary();
    if(file != null){
      image.value = file;
    }
  }

  // to reset post threds state
  void resetState(){
    content.value ="";
    textEditingController.text = "";
    image.value =null ;
  }

  @override
  void onClose(){
    textEditingController.dispose();
    super.onClose();
  }
  void store(String userId)async{
    try{
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";
      var imgPath = "";
      if(image.value!=null && image.value!.existsSync()){
        imgPath = await SupabaseService.client.storage.from(Env.s3Bucket).upload(dir, image.value!);

      }

      // Add post in db
      await SupabaseService.client.from('posts').insert({
        "user_id":userId,
        "content":content.value,
        "image":imgPath.isNotEmpty ? imgPath:null
      });
      loading.value=false;
      resetState();
      Get.find<NavigationService>().currentIndex.value =0;
      showSnackBar('Success', 'Thread added sucessfully');

    }on StorageException catch (error){
       loading.value = false;
       showSnackBar('Error', error.message);
    } catch(error){
      loading.value = false;
      showSnackBar('Error', "Something went wrong! retry");
    }

  }

  //To show post/thread

 void show(int postId) async{
    try{
      post.value = PostModel();
      replies.value = [];
      showThreadLoading.value = true;
      final response = await SupabaseService.client.from("posts").select(
          ''' 
      id, content, image,created_at , comment_count, like_count , user_id,
      user:user_id (email , metadata) , likes:likes (user_id,post_id)
      '''
      ).eq("id", postId).single();
      showThreadLoading.value=false;
      post.value = PostModel.fromJson(response);
      // Fetch replies
      fetchPostReplies(postId);
    }catch(e){
      showThreadLoading.value = false;
      showSnackBar("Error","Something went wrong retry" );
    }
 }

 // To like and dislike
  Future<void> likeDislike(String status ,int postId , String postUserId, String userId)async{
     if(status == "1"){
       await SupabaseService.client.from("likes")
           .insert({"user_id":userId,"post_id":postId});

       // Add Like notification
       await SupabaseService.client.from("notifications").insert({
         "user_id":userId,
         "notification":"Liked on your post",
         "to_user_id":postUserId,
         "post_id":postId,
       });

       //Increment the like counter
       await SupabaseService.client.rpc("like_increment",params: {"count":1, "row_id":postId});
     }
     else{
       //Delete entry from like table
       await SupabaseService.client.from("likes")
           .delete()
           .match({"user_id":userId, "post_id":postId});
       // Decrement post count
       await SupabaseService.client.rpc("like_decrement",params: {"count":1, "row_id":postId});


     }
  }

 // Fetch Post replies
void fetchPostReplies(int postId) async{
    try{
      showReplyLoading.value = true;
       final List<dynamic> response = await SupabaseService.client.from("comments").select(''' 
      id, user_id, post_id, reply, created_at, user:user_id (email, metadata)
      '''
      ).eq("post_id", postId);
       showReplyLoading.value = false;
       if(response.isNotEmpty){
         replies.value = [for(var item in response) ReplyModel.fromJson(item)];
       }

    }catch(e){
      showReplyLoading.value = false;
      showSnackBar("Error","Something went wrong retry" );
    }
}

}

