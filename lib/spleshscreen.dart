import 'dart:async';

import 'package:firebasework/firebaseclass.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  void initState() {
    super.initState();
    msg = checkUser();
  }
  bool msg = false;
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3),()=> msg?Get.offNamed('home'):Get.offNamed('login'));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("All In One Food App",style: TextStyle(color: Colors.black),),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/images/food.png',fit: BoxFit.fill,),
            ),
            SizedBox(height: 20,),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
