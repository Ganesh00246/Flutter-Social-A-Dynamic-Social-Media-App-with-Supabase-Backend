import 'package:clone/controllers/profile_controller.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileController controller = Get.find<ProfileController>();
  final TextEditingController textEditingController = TextEditingController(
      text: "");
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  void initState() {
    if (supabaseService.currentUser.value?.userMetadata?["description"] != null) {
      textEditingController.text =
      supabaseService.currentUser.value?.userMetadata?["description"];
    }

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit profile"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Obx(() {
              return TextButton(
                  onPressed: () {
                    controller.updateProfile(
                        supabaseService.currentUser.value!.id,
                        textEditingController.text);
                  },
                  child: controller.loading.value
                      ? CircularProgressIndicator()
                      : Text("Done"),
                );
            }),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(() {
                return Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleImage(
                      radius: 80,
                      file: controller.image.value,
                      url: supabaseService.currentUser.value
                          ?.userMetadata?["image"],
                    ),
                    IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white60,
                        child: Icon(
                            Icons.edit
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20,),
              TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Your description',
                    label: Text("Description")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
