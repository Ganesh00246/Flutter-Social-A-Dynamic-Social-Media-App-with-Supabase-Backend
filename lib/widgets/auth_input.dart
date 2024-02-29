import 'package:clone/utils/type_def.dart';
import 'package:flutter/material.dart';
class AuthInput extends StatelessWidget {
  final String label , hintText;
  final bool isPasswordField;
  final TextEditingController controller;
  final ValidatorCallback validatorCallback;
  const AuthInput({super.key, required this.label, required this.hintText,this.isPasswordField=false, required this.controller, required this.validatorCallback});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validatorCallback,
      obscureText: isPasswordField,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)
          ),
          label: Text(label),
          hintText: hintText,
      ),
    );
  }
}
