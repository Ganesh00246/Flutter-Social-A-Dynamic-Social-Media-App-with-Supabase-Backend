
import 'dart:io';

import 'package:clone/models/post_model.dart';
import 'package:clone/models/reply_model.dart';
import 'package:clone/models/user_model.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/env.dart';
import 'package:clone/utils/helper.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController{
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);
  var postLoading =false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  var replyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();
  var userLoading = false.obs;
  Rx<UserModel> user = Rx<UserModel>(UserModel());

  //update profile method
  Future<void> updateProfile(String userId,String description)async{
    try{
      loading.value = true;
      var uploadedpath ="";
      if(image.value != null && image.value!.existsSync()){
        final String dir = "$userId/profile.jpg";
        var path = await SupabaseService.client.storage.from(Env.s3Bucket).upload(dir, image.value!,
            fileOptions: const FileOptions(upsert: true) );
        uploadedpath = path;
      }

    //Update Profile
      await SupabaseService.client.auth.updateUser(UserAttributes(
        data: {
          "description":description,
          "image":uploadedpath.isNotEmpty ? uploadedpath : null
        }

      ));


    loading.value = false;
    Get.back();
    showSnackBar("Success", "Profile updated successfully");
    } on StorageException catch(error){
      loading.value = false;
      showSnackBar("Error", error.message);
    }on AuthException catch(error){
      loading.value = false;
      showSnackBar("Error", error.message);
    }catch(error){
      loading.value=false;
      showSnackBar("Error", "Something went wrong. Please try again");
    }
  }

  void pickImage()async{
     File? file = await pickImageFromGallary();
     if(file != null)image.value=file;
  }
  // Fetch Posts

  void fetchUserThreads(String userId)async{
    try{
      postLoading.value = true;
      final List<dynamic> response = await SupabaseService.client.from('posts').select(''' 
      id, content, image,created_at , comment_count, like_count , user_id,
      user:user_id (email , metadata), likes:likes(user_id,post_id)
      '''
      ).eq("user_id",userId).order('id',ascending: false);
     postLoading.value=false;
      if(response.isNotEmpty){
        posts.value = [for(var item in response) PostModel.fromJson(item)];
      }
    }catch(e){
      postLoading.value=false;
      showSnackBar("Error", "Something went wrong retry");
    }

  }

  //Fetch replies
    void fetchReplies(String userId) async{
    try{
      replyLoading.value=true;
      final List<dynamic> response = await SupabaseService.client.from("comments").select(''' 
      id, user_id, post_id, reply, created_at, user:user_id (email, metadata)
      '''
      ).eq("user_id", userId).order("id",ascending: false);
      replyLoading.value =false;
      if(response.isNotEmpty){
        replies.value = [for(var item in response) ReplyModel.fromJson(item)];
      }

    } catch(e){
      replyLoading.value=false;
      showSnackBar("Error", "Something went wrong retry");
    }

    }

    // Fetch User
void fetchUser(String userId) async{
    try{
       userLoading.value= true;
       final response = await SupabaseService.client.from("users").select("*").eq("id", userId).single();
       userLoading.value = false;
       user.value = UserModel.fromJson(response);
       // Fetch user threads and replies
      fetchUserThreads(userId);
      fetchReplies(userId);
    }catch(e){
      userLoading.value = false;
      showSnackBar("Error", "Something went wrong");
    }
}

// Delete threads

Future<void> deleteThread(int postId)async{

    try{
      await SupabaseService.client.from("posts").delete().eq("id", postId);
      posts.removeWhere((element) => element.id == postId);
      if(Get.isDialogOpen == true) Get.back();

      showSnackBar("Sucess", "Post deleted successfully");

    }catch(e){
      showSnackBar("Error", "Something went wrong");
    }

}

// Delete Reply
  Future<void> deleteReply(int replyId)async{

    try{
      await SupabaseService.client.from("comments").delete().eq("id", replyId);
      replies.removeWhere((element) => element.id == replyId);
      if(Get.isDialogOpen == true) Get.back();

      showSnackBar("Success", "Reply deleted successfully");

    }catch(e){
      showSnackBar("Error", "Something went wrong");
    }

  }

}