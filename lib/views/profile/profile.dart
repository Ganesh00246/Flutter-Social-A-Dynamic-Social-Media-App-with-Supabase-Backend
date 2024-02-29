import 'package:clone/controllers/profile_controller.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/styles/button_styles.dart';
import 'package:clone/views/settings/settings.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:clone/widgets/reply_card.dart';
import 'package:clone/widgets/loading.dart';
import 'package:clone/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ProfileController controller = Get.put(ProfileController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    if (supabaseService.currentUser.value?.id != null) {
      controller.fetchUserThreads(supabaseService.currentUser.value!.id);
      controller.fetchReplies(supabaseService.currentUser.value!.id);
    }
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
                  expandedHeight: 160,
                  collapsedHeight: 160,
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
                                  Text(supabaseService.currentUser.value!
                                      .userMetadata?["name"],
                                    style: TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold),),
                                  SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.63,
                                      child: Text(
                                          supabaseService.currentUser.value
                                              ?.userMetadata?["description"] ??
                                              "Enter Description"))
                                ],
                              );
                            }),
                            CircleImage(
                              radius: 40,
                              url: supabaseService.currentUser.value
                                  ?.userMetadata?["image"],
                            ),

                          ],
                        ),
                        const SizedBox(height: 15,),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () =>
                                    Get.toNamed(RouteNames.editProfile),
                                child: Text("Edit Profile"),
                                style: customOutlineStyle(),
                              ),
                            ),
                            const SizedBox(width: 30,),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                child: Text("Share Profile"),
                                style: customOutlineStyle(),
                              ),
                            )
                          ],
                        )
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
                        Tab(text: 'Posts',),
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
                                      PostCard(post: controller.posts[index],isAuthCard: true,callback: controller.deleteThread,)
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
    );
  }
}
//sliver persistanceHeader class

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;


  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}