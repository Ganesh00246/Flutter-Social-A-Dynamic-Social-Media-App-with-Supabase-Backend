import 'package:clone/utils/type_def.dart';
import 'package:flutter/material.dart';
class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final InputCallback callback;
  const SearchInput({super.key, required this.controller, required this.callback});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: callback,
      decoration: const InputDecoration(
        prefixIcon:  Icon(Icons.search,color: Colors.grey,),
        filled: true,
        fillColor:  Color(0xff242424),
        hintText: "Search user...",
        hintStyle:  TextStyle(
          color: Colors.grey
        ),
        contentPadding:  EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
      ),

    );
  }
}
