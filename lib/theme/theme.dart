import 'package:flutter/material.dart';
final ThemeData theme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    surfaceTintColor: Colors.black,
  ),brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,
    background: Colors.black,
    onBackground: Colors.white,
    surfaceTint: Colors.black12,
    primary: Colors.white,
    onPrimary: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
    )
  ),
navigationBarTheme:  NavigationBarThemeData(
  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
  height: 60,
  indicatorColor: Colors.transparent,
  // backgroundColor: Colors.black,
  iconTheme: MaterialStateProperty.all<IconThemeData>(
   const IconThemeData(color: Colors.white,size: 24)
  )

)
  
);