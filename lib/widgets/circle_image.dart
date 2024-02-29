import 'dart:io';

import 'package:clone/utils/helper.dart';
import 'package:flutter/material.dart';
class CircleImage extends StatelessWidget {
  const CircleImage({super.key,  this.radius=20,this.file,this.url});
  final double radius;
  final String? url;
  final File? file;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(file !=null)
          CircleAvatar(
            backgroundImage: FileImage(file!),
            radius: radius,
          )
        else if(url != null)
          CircleAvatar(
            backgroundImage: NetworkImage(getS3Url(url!)),
            radius: radius,
          )
        else
          CircleAvatar(
            radius: radius,
            backgroundImage: const AssetImage('assets/images/avatar.png'),
          ),

      ],
    );
  }
}
