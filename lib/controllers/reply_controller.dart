import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReplyController extends GetxController{
  final TextEditingController replyController = TextEditingController(text:"");
  var loading = false.obs;
  var reply = "".obs;
  void addReply(String userId,int postId,String postUserId)async{
    try{
      loading.value = true;

      //Increase the post comment count
      await SupabaseService.client.rpc("comment_increment"
          ,params: {"count":1,"row_id":postId}
      );
      // Add notification
      await SupabaseService.client.from("notifications").insert({
        "user_id":userId,
        "notification":"Commented on your post",
        "to_user_id":postUserId,
        "post_id":postId,
      });
      //Add comment in table
      await SupabaseService.client.from("comments").insert({
        "post_id":postId,
        "user_id":userId,
        "reply":replyController.text,
      });
       loading.value = false;
       showSnackBar("Success", "Replied successfully");
    }catch(e){
      loading.value = false;
      showSnackBar("Error", "Something went wrong retry");
    }
  }

  @override
  void onClose(){
    replyController.dispose();
    super.onClose();
  }
}