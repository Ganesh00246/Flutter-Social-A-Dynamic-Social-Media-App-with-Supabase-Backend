import 'dart:io';

import 'package:clone/widgets/confirm_dailog.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';

import 'env.dart';
void showSnackBar(String tittle,String message){
  Get.snackbar(tittle,message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: const Color(0xff252526),
    padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
    snackStyle: SnackStyle.GROUNDED,
    margin: const EdgeInsets.all(10),
  );
}

//Pick Image from Gallery
Future<File?> pickImageFromGallary()async{
  const uuid = Uuid();
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if(file==null)return null;
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
  File image = await compressImage(File(file.path), targetPath);
  return  image;
}


//Compress image file

Future<File> compressImage(File file,String targetPath)async{
  var result = await FlutterImageCompress.compressAndGetFile(file.path, targetPath,quality: 70);
  return File(result!.path);
}

// To get s3 url
String getS3Url(String path){
  return "${Env.supabaseUrl}/storage/v1/object/public/$path";
}
// Confirm Dailog
void confirmDialog(String title,String text, VoidCallback callback){
  Get.dialog(ConfirmDialog(title: title,text: text, callback:callback,));
}
// Format data
String formateDateFromNow(String data){
  //parse utc timestamp to datetime
  DateTime utcDateTime = DateTime.parse(data.split("+")[0].trim());

  // Convert Utc To Ist
  DateTime isDateTime = utcDateTime.add(const Duration(hours:5,minutes: 30 ));

  //Formate date
  return Jiffy.parseFromDateTime(isDateTime).fromNow();
}