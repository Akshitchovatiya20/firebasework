import 'package:firebasework/firebaseclass.dart';
import 'package:firebasework/homescreen.dart';
import 'package:firebasework/signinscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/loginbackground.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text(
                  "Login",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text("Please enter you Login and your Password",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtemail,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.red,
                      hoverColor: Colors.orange,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white,width: 2)),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                      hintText: 'Username or E-mail',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                            width: 2
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: txtpass,
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.red,
                      hoverColor: Colors.orange,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white,width: 2)),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 30,
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(SigninScreen());
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: ()async{
                  String msg = await loginscreenn(txtemail.text, txtpass.text);
                  Get.snackbar(
                    titleText: Text("Login"),
                    "$msg",'$msg',
                    backgroundColor: Colors.grey.shade300,
                    icon: Icon(Icons.person, color: Colors.black),
                    duration: const Duration(seconds: 1),
                  );
                  if(msg == "Success")
                  {
                    Get.offNamed('home');
                  }
                },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    minimumSize: Size(150, 50),
                  ),
                  child: Text("Login"),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member yet? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontStyle: FontStyle.italic),
                    ),
                    TextButton(
                      onPressed: () async {
                        Get.to(SigninScreen());
                      },
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(
                        "Register!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(onPressed: (){

                      }, icon: Icon(Icons.facebook,size: 35,color: Colors.blue,)),
                    ),
                    SizedBox(width: 20,),
                    InkWell(
                      onTap: ()async{
                        bool msg = await signInWithGoogle();
                        if(msg)
                          {
                            Get.to(HomeScreen());
                          }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset("assets/icon/google.png",height: 20,width: 20,fit: BoxFit.fill,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





















