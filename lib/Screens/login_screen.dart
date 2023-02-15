import 'package:exd_social/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  /*
  creating Objects(states or instance) for class LoginScreen
  * formkey, emailController and  passwordController
  * final is defined so after compile time the values cannot be overridden(cannot be change)*/
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /*creating state to set heightScreen and widthScreen in UserInterface*/
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.orange.shade200,
        //using Getx stateManagement to extend states and methods from LoginController class
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (logic) {
              return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                height: heightScreen,
                width: widthScreen,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration:
                        BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.elliptical(100, 60),
                                bottomLeft: Radius.elliptical(100, 60),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        height: heightScreen * 0.1,
                        width: widthScreen * 0.9,
                        child: Text("Welcome to Social App",
                            style: TextStyle(fontSize: 25)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                                top: Radius.circular(50))),
                        width: widthScreen * 0.8,
                        height: heightScreen * 0.5,
                        child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  child: TextFormField(
                                      controller: emailController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1)),
                                        prefixIcon: Icon(
                                          Icons.mail,
                                          color: Colors.black,
                                        ),
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Enter Email";
                                        }
                                        return null;
                                      },
                                      style: TextStyle()),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 40),
                                  child: TextFormField(
                                      controller: passwordController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black, width: 1)),
                                        prefixIcon: Icon(
                                          Icons.key,
                                          color: Colors.black,
                                        ),
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      validator: (value) {
                                        return null;
                                      },
                                      style: TextStyle()),
                                ),
                              ],
                            )),
                      ),
                      Container(height: heightScreen *0.07,width: widthScreen *0.5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.red)),
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              logic.login(context, emailController.text,
                                  passwordController.text);
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        child: TextButton(
                            onPressed: () {
                              Get.to(()=>SignupScreen());
                            },
                            child: Text(
                              "Not a User! tap to Signup here",
                              style: TextStyle(fontSize: 20),
                            )),
                      )
                    ],
                ),
              ),
                  ));
            }));
  }
}

