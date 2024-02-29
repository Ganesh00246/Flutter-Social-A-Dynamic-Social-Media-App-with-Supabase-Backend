import 'package:clone/controllers/thread_controller.dart';
import 'package:clone/models/post_model.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCardBottomBar extends StatefulWidget {
  final PostModel post;

  const PostCardBottomBar({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCardBottomBar> createState() => _PostCardBottomBarState();
}

class _PostCardBottomBarState extends State<PostCardBottomBar> {
  String likeStatus = "";
  final ThreadController controller = Get.put(ThreadController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  void likeDisLike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if(likeStatus =="0"){
      widget.post.likes =[];
    }
    await controller.likeDislike(
        status, widget.post.id!, widget.post.userId!, supabaseService.currentUser.value!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == "1" || widget.post.likes!.isNotEmpty
                ? IconButton(
                onPressed: () {
                  likeDisLike("0");
                },
                icon: Icon(Icons.favorite, color: Colors.red[700]))
                : IconButton(
                onPressed: () {
                  likeDisLike("1");
                },
                icon: const Icon(Icons.favorite_outline)),
            IconButton(
                onPressed: () {
                  Get.toNamed(RouteNames.addReply, arguments: widget.post);
                },
                icon: const Icon(Icons.chat_bubble_outline)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
          ],
        ),
        Row(
          children: [
            Text("${widget.post.commentCount} likes"),
            const SizedBox(width: 10,),
            Text("${widget.post.likeCount} replies")
          ],
        ),
      ],
    );
  }
}
