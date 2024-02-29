import 'package:clone/controllers/profile_controller.dart';
import 'package:clone/views/profile/profile.dart';
import 'package:clone/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes_name.dart';
import '../../utils/styles/button_styles.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/post_card.dart';
import '../../widgets/reply_card.dart';
class ShowUsers extends StatefulWidget {
  const ShowUsers({super.key});

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  final String userId = Get.arguments;
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState(){
    controller.fetchUser(userId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.language),
        centerTitle: false,
        actions: [
          IconButton(onPressed: () {
            Get.toNamed(RouteNames.settings);
          }, icon: Icon(Icons.sort_rounded))
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 100,
                  collapsedHeight: 100,
                  automaticallyImplyLeading: false,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if(controller.userLoading.value)
                                    const Loading()
                                  else
                                  Text(
                                  controller.user.value.metadata!.name!
                                    ,
                                    style: TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.63,
                                      child: Text(
                                          controller.user.value.metadata?.description ??
                                              "Enter Description"))
                                ],
                              );
                            }),
                            CircleImage(
                              radius: 40,
                              url: controller.user.value.metadata?.image,
                            ),

                          ],
                        ),
                       const SizedBox(height: 20,),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    const TabBar(

                      tabs: [
                        Tab(text: 'Threads',),
                        Tab(text: "Replies"),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                Obx(() =>
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                          if(controller.postLoading.value)
                            const Loading()
                          else
                            if(controller.posts.isNotEmpty)
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.posts.length,
                                  itemBuilder: (context, index) =>
                                      PostCard(post: controller.posts[index])
                              )
                            else
                              const Center(
                                child: Text("Not uploaded post yet!"),
                              )
                        ],
                      ),
                    )),
                Obx(()=>SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        if(controller.replyLoading.value)
                          const Loading()
                        else if(controller.replies.isNotEmpty)
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.replies.length,
                              //Here the comments display in replies
                              itemBuilder: (context,index)=>ReplyCard(reply: controller.replies[index])
                          )
                        else
                          const Center(
                            child: Text("No reply found!"),
                          )
                      ],
                    ),
                  ),
                )
                ),
              ],
            )
        ),
      ),
    );;
  }
}
