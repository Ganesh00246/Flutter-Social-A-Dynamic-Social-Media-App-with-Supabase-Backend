import 'dart:async';

import 'package:clone/models/user_model.dart';
import 'package:clone/services/supabase_service.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController{
  var loading = false.obs;
  var notFound = false.obs;
  RxList<UserModel> users = RxList<UserModel>();

  Timer? _debounce;
  Future<void> searchUser(String name)async{
    loading.value = true;
    notFound.value = false;
    if(_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce=Timer(const Duration(microseconds: 500),()async
    {
      if(name.isNotEmpty){
        final List<dynamic> data = await SupabaseService.client.from("users").select("*")
            .ilike("metadata->>name", "%$name%");
        loading.value = false;
        if(data.isNotEmpty){
          users.value=[for(var item in data) UserModel.fromJson(item)];
        } else{
          notFound.value = true;
        }
      }
      loading.value = false;
    });
  }

}