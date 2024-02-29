import 'package:clone/routes/routes_name.dart';
import 'package:clone/services/storage_service.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/utils/storage_keys.dart';
import 'package:get/get.dart';

class SettingController extends GetxController{
  void logout()async{
    //remove user session from local storage
    StorageService.session.remove(StorageKeys.userSession);
    await SupabaseService.client.auth.signOut();
    Get.offAllNamed(RouteNames.login);
  }
}