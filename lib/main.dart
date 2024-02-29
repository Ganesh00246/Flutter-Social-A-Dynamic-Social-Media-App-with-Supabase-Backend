import 'package:clone/routes/routes.dart';
import 'package:clone/routes/routes_name.dart';
import 'package:clone/services/storage_service.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:clone/theme/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.noTransition,
      debugShowCheckedModeBanner: false,
      title: 'FunZone',
      theme: theme,
      getPages: Routes.pages,
      initialRoute: StorageService.userSession != null?RouteNames.home: RouteNames.login,

    );
  }
}
