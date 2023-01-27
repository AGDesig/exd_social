
import 'package:exd_social/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery
        .of(context)
        .size
        .height;
    var widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        body: GetBuilder<LoginController>(init: LoginController(),builder: (logic) {
          return SafeArea(
              child: Container(
                width: widthScreen,
                height: heightScreen,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          alignment: Alignment.center,
                          height: heightScreen * 0.1,
                          width: widthScreen,
                          child:
                          Text("Welcome to Social App",
                              style: TextStyle(fontSize: 40)),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          decoration: BoxDecoration(
                              color: Colors.deepOrange.shade400,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  40))),
                          width: widthScreen * 0.9,
                          height: heightScreen * 0.4,
                          padding: EdgeInsets.all(30),
                          child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade200,
                                  borderRadius: BorderRadius.all(
                                      Radius.elliptical(60, 40))),
                              child: Form(
                                  key: formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      TextFormField(
                                          controller: emailController,
                                          cursorColor: Colors.black,
                                          toolbarOptions:
                                          ToolbarOptions(
                                              copy: true, paste: true),
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1)),
                                            prefixIcon: Icon(
                                              Icons.mail,
                                              color: Colors.white,
                                            ),
                                            labelText: "Email",
                                            labelStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Enter Email";
                                            }
                                            return null;
                                          },
                                          style: TextStyle()),
                                      TextFormField(
                                          controller: passwordController,
                                          toolbarOptions:
                                          ToolbarOptions(
                                              copy: true, paste: true),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1)),
                                            prefixIcon: Icon(
                                              Icons.mail,
                                              color: Colors.white,
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
                                    ],
                                  ))),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              logic.login(context, emailController.text, passwordController.text);
                            }
                          },
                          child: Text("Login"),
                        ),
                        Container(
                          child: TextButton(
                              onPressed: () {
                                Get.to(SignupScreen());
                              },
                              child: Text("Not a User! tap to Signup here")),
                        )
                      ],
                    )),
              ));
        }));
  }
}
