import 'package:firebasework/firebaseclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  TextEditingController txtmob = TextEditingController();
  var txtkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: txtkey,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/signinback.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          "Please enter details to register",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20,color: Colors.white),
                      controller: txtemail,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Colors.red,
                        hoverColor: Colors.orange,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black,width: 2)),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                        hintText: 'Username or E-mail',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Username or E-mail";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20,color: Colors.white),
                      controller: txtpass,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Colors.red,
                        hoverColor: Colors.orange,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black,width: 2)),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Your Password";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(fontSize: 20,color: Colors.white),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: txtmob,
                      decoration: InputDecoration(
                        focusColor: Colors.black,
                        fillColor: Colors.red,
                        hoverColor: Colors.orange,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.black,width: 2)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 30,
                        ),
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(onPressed: ()async{
                    String msg = await signinscreen(txtemail.text, txtpass.text);
                    Get.snackbar(
                      titleText: Text("Sign In"),
                      "$msg",'$msg',
                      backgroundColor: Colors.grey.shade300,
                      icon: Icon(Icons.person, color: Colors.black),
                      duration: const Duration(seconds: 1),
                    );
                    if(msg == "Success")
                    {
                      Get.offNamed('login');
                    }
                  }, style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(150, 50),
                  ),
                    child: Text("Register!"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
