import 'package:clone/models/post_model.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/type_def.dart';
class PostTopBar extends StatelessWidget {
  final PostModel post;
  final bool isAuthCard;
  final DeleteCallback? callback;
  const PostTopBar({super.key, required this.post ,  this.isAuthCard = false, this.callback});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap:()=> Get.toNamed(RouteNames.showUser,arguments: post.userId),
            child: Text(post.user!.metadata!.name! ,style: const TextStyle(fontWeight: FontWeight.bold),)),
        Row(
          children: [
            Text(formateDateFromNow(post.createdAt!)),
            const SizedBox(width: 10,),
            isAuthCard? GestureDetector(
              onTap: () {
                confirmDialog(
                    "Are you sure", "Once it's deleted then you won't recover it.", () {
                  callback!(post.id!);
                });
              },
              child: Icon(Icons.delete ,color: Colors.red,),
            ) : const Icon(Icons.more_horiz)
          ],
        )
      ],
    );
  }
}
