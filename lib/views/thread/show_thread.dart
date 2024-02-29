import 'package:clone/controllers/thread_controller.dart';
import 'package:clone/widgets/loading.dart';
import 'package:clone/widgets/post_card.dart';
import 'package:clone/widgets/reply_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final int postId = Get.arguments;
  final ThreadController controller = Get.put(ThreadController());

  @override
  void initState() {
    controller.show(postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Posts"),
      ),
      body: Obx(() => controller.showThreadLoading.value? const Loading() :SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                PostCard(post: controller.post.value),
                const SizedBox(height: 20,),

                // Load post replies
                if(controller.showReplyLoading.value)
                   const Loading()
                else if(controller.replies.isNotEmpty)
                  ListView.builder(
                    itemCount: controller.replies.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context ,index) => ReplyCard(reply: controller.replies[index])
                  )
                else
                  const Center(
                    child: Text('No reply found'),
                  )
              ],
            ),
          ),
        )
      ),
    );
  }
}
