import 'package:clone/routes/routes_name.dart';
import 'package:clone/utils/type_def.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:clone/widgets/post_card_bottom_bar.dart';
import 'package:clone/widgets/post_card_image.dart';
import 'package:clone/widgets/post_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/post_model.dart';
class PostCard extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
   const PostCard({super.key, required this.post,  this.isAuthCard = false, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width*0.12,

                //******** HERE I CHANGED ON TAP AVATAR THE USER IS REDIRECTING TO THEIR PROFILE

                child: GestureDetector(
                  onTap:()=> Get.toNamed(RouteNames.showUser,arguments: post.userId),
                  child: CircleImage(
                    url: post.user?.metadata?.image,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   PostTopBar(post: post , isAuthCard: isAuthCard, callback: callback,),
                    //  this is post content description
                    GestureDetector(
                      onTap: ()=>{
                        Get.toNamed(RouteNames.showThread,arguments: post.id),
                      },
                        child: Text(post.content!)),

                    const SizedBox(height: 10,),
                    if(post.image !=null)
                      GestureDetector(
                        onTap: (){
                          Get.toNamed(RouteNames.showImage,arguments:post.image!);
                        },
                          child: PostCardImage(url: post.image!)),

                    PostCardBottomBar(post: post),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            color: Color(0xff242424),
          )
        ],
      ),
    );
  }
}
