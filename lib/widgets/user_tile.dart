import 'package:clone/models/user_model.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/utils/helper.dart';
import 'package:clone/utils/styles/button_styles.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(padding: const EdgeInsets.only(top: 5),
      child: CircleImage(url:user.metadata?.image ,),
      ),
      title: Text(user.metadata!.name!),
      trailing: OutlinedButton(
        style: customOutlineStyle(),
        onPressed: (){
          Get.toNamed(RouteNames.showUser,arguments: user.id);
        },
         child: const Text("View Profile"),
      ),
      subtitle: Text(formateDateFromNow(user.createdAt!)),

    );
  }
}
