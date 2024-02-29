import 'package:clone/views/home/home_page.dart';
import 'package:clone/views/notification/notification.dart';
import 'package:clone/views/profile/profile.dart';
import 'package:clone/views/search/search.dart';
import 'package:clone/views/thread/add_thread.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class NavigationService extends GetxService{
  var currentIndex = 0.obs;
  var previouseIndex =0.obs;

  //pages
List<Widget> pages(){
  return [
     HomePage(),
     Search(),
     AddThread(),
     Notifications(),
     Profile(),
  ];
}
//update index
void updateIndex(int index){
  previouseIndex.value = currentIndex.value;
  currentIndex.value= index;
}
// Bakc to previous page
void backToPrevPage(){
  currentIndex.value=previouseIndex.value;
}
}



