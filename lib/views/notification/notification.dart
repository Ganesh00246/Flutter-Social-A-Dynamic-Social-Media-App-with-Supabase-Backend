import 'package:clone/controllers/notification_controller.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/services/navigation_service.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/helper.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:clone/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    controller.fetchNotification(Get
        .find<SupabaseService>()
        .currentUser
        .value!
        .id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.find<NavigationService>().backToPrevPage(),
          icon: const Icon(Icons.close),
        ),
        title: Text('Notifaction'),
      ),
      body: SingleChildScrollView(
        child: Obx(()=> controller.loading.value? const Loading() :Column(
          children: [
            if(controller.notifications.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.notifications.length,
                  itemBuilder: (context,index){
                  return Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: ()=>{
                        Get.toNamed(RouteNames.showThread,arguments: controller.notifications[index].postId)
                      },
                      leading: CircleImage(
                        radius: 24,
                        url: controller.notifications[index].user?.metadata?.image,
                      ),
                      title:Text(controller.notifications[index].user!.metadata!.name!),
                      trailing: Text(formateDateFromNow(controller.notifications[index].createdAt!)),
                      subtitle: Text(controller.notifications[index].notification!),

                    ),
                  );
              })
            else
             const Text("No Notification Found Yet"),
          ],
        )
        ),
      ),
    );
  }
}
