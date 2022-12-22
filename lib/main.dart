import 'package:firebase_core/firebase_core.dart';
import 'package:firebasework/homescreen.dart';
import 'package:firebasework/imagescreen.dart';
import 'package:firebasework/loginscreen.dart';
import 'package:firebasework/spleshscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'signinscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      initialRoute: 'image',
      routes: {
        '/':(context) => SpleshScreen(),
        'sign':(context) => SigninScreen(),
        'login':(context) => LoginScreen(),
        'home':(context) => HomeScreen(),
        'image':(context) => ImageScreen(),
      },
    ),
  );
}
