import 'package:flutter/material.dart';

ButtonStyle customOutlineStyle(){
  return ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
      )
  );
}