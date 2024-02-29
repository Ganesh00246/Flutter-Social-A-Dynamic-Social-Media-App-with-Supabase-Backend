import 'package:clone/controllers/thread_controller.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/widgets/add_thread_appbar.dart';
import 'package:clone/widgets/circle_image.dart';
import 'package:clone/widgets/thread_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddThread extends StatefulWidget {
  const AddThread({super.key});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ThreadController controller = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
               AddThreadAppBar(),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return CircleImage(
                      url: supabaseService.currentUser.value!
                          .userMetadata?["image"],
                    );
                  }),
                  const SizedBox(width: 10,),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Text(supabaseService.currentUser.value!
                              .userMetadata?["name"]);
                        }),
                        TextField(
                          autofocus: true,
                          controller: controller.textEditingController,
                          onChanged: (value) =>
                          controller.content.value = value,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            hintText: 'type a Feed content ',
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Icon(Icons.attach_file
                          ),
                        ),
                        //TO Preview user image
                        Obx(() {
                          return Column(
                            children: [
                              if(controller.image.value !=null)
                                  ThreadImagePreview(),
                            ],
                          );
                        })

                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
