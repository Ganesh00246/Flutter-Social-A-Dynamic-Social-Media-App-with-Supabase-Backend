import 'package:clone/controllers/setting_controller.dart';
import 'package:clone/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Setting extends StatelessWidget {
   Setting({super.key});
final SettingController controller = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: (){
                confirmDialog("Are you Sure ?","This action can logout you from app",controller.logout);
              },
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
            )
          ],
        ),
      ),
    );
  }
}
