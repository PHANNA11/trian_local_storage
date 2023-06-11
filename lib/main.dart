import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_storage/view/auth/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/constant/global.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
