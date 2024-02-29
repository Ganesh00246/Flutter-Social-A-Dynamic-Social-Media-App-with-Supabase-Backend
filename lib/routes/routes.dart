import 'package:clone/auth/login.dart';
import 'package:clone/auth/register.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/views/home.dart';
import 'package:clone/views/profile/edit_profile.dart';
import 'package:clone/views/profile/show_user.dart';
import 'package:clone/views/replies/add_reply.dart';
import 'package:clone/views/settings/settings.dart';
import 'package:clone/views/thread/show_image.dart';
import 'package:clone/views/thread/show_thread.dart';
import 'package:get/get.dart';
class Routes{
  static final pages = [
    GetPage(name: RouteNames.home, page: ()=>Home()),
    GetPage(name: RouteNames.login, page: ()=>const Login(),transition: Transition.fade) ,
    GetPage(name: RouteNames.register, page: ()=>const Register(),transition: Transition.fadeIn),
    GetPage(name: RouteNames.editProfile, page: ()=>const EditProfile(),transition: Transition.leftToRight),
    GetPage(name: RouteNames.settings, page: ()=> Setting(),transition: Transition.rightToLeft),
    GetPage(name: RouteNames.addReply, page: ()=> AddReply(),transition: Transition.downToUp),
    GetPage(name: RouteNames.showThread, page: ()=> const ShowThread(),transition: Transition.leftToRight),
    GetPage(name: RouteNames.showImage, page: ()=>  ShowImage(),transition: Transition.fadeIn),
    GetPage(name: RouteNames.showUser, page: ()=>  const ShowUsers(),transition: Transition.topLevel),

  ];
}