
import 'package:clone/models/user_model.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/post_model.dart';
class HomeController extends GetxController{
  var loading = false.obs;
  RxList<PostModel> posts = RxList<PostModel>();
  @override
  void onInit()async{
    await fetchThreads();

    super.onInit();
  }


  Future<void> fetchThreads()async{
    loading.value = true;
    final List<dynamic> response = await SupabaseService.client.from('posts').select(
      ''' 
      id, content, image,created_at , comment_count, like_count , user_id,
      user:user_id (email , metadata) , likes:likes (user_id,post_id)
 
      '''
    ).order('id',ascending: false);
 loading.value = false;
    if(response.isNotEmpty){
      posts.value =[for(var item in response) PostModel.fromJson(item)];
    }
  }

//
// //Listen Realtime threads changes
// void listenChanges() async{
//   SupabaseService.client.channel('public:posts').on(
//     .postgresChanges,
//     ChannelFilter(event: 'INSERT', schema: 'public', table: 'posts'),
//         (payload, [ref]) {
//       final PostModel post = PostModel.fromJson(payload["new"]);
//       updateFeed(post);
//       print('Change received: ${payload.toString()}');
//     },
//   ).subscribe();
// }
//
// // To update the feed
// void updateFeed(PostModel post) async{
//   var user = await SupabaseService.client.from("users").select("*").eq("id", post.userId).single();
//   post.likes = [];
//   post.user = UserModel.fromJson(user);
//   posts.insert(0, post);
// }



}

