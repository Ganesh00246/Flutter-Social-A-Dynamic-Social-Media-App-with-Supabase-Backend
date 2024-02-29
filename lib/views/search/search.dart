import 'package:clone/controllers/search_user_controller.dart';
import 'package:clone/widgets/loading.dart';
import 'package:clone/widgets/search_input.dart';
import 'package:clone/widgets/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController textEditingController = TextEditingController(text: "");
final SearchUserController controller = Get.put(SearchUserController());
  void searchUser(String? name) async{
    if(name != null){
       controller.searchUser(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: CustomScrollView(
       slivers: [
         SliverAppBar(
           floating: true,
           centerTitle: false,
           title: const Text("Search",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
           ),
           expandedHeight: GetPlatform.isIOS?110 : 105,
           collapsedHeight: GetPlatform.isIOS ? 90 : 80,
           flexibleSpace: Padding(padding:  EdgeInsets.only(
             top: GetPlatform.isIOS?105: 80 , left: 10,right: 10
           ),
             child: SearchInput(controller: textEditingController,callback: searchUser,),
           ),
         ),
         SliverToBoxAdapter(
           child: Obx(()=> controller.loading.value ? const Loading(): Column(
             children: [
               if(controller.users.isNotEmpty)
                 ListView.builder(
                   shrinkWrap: true,
                   physics: BouncingScrollPhysics(),
                   itemCount: controller.users.length,
                   itemBuilder: (context,index)=> UserTile(user: controller.users[index]),)
               else if(controller.users.isEmpty && controller.notFound.value == true)
                 const Text("No User Found")
               else
                 const Center(
                   child: Padding(padding: EdgeInsets.only(top:20 ),
                   child: Text("Search users with their names"),
                   ),
               )
             ],
           )),
         )
       ],
     ),
    );
  }
}
