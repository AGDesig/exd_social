import 'package:exd_social/Auth/firebase_auth.dart';
import 'package:exd_social/db/firebase_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController educationController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  bool showPassword = false;

  GlobalKey<FormState> formkey = GlobalKey();

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    var widthscreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: GetBuilder<SignupScreenController>(
          init: SignupScreenController(),
          builder: (logic) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    width: widthscreen,
                    height: heightScreen,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Welcome To create user detail"),
                        TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "please Enter Data";
                              }
                            },
                            controller: nameController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                                label: Text("Name"))),
                        TextFormField(
                          validator: (value) => logic.validateName(value),
                          controller: emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Email")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            } else if (!validateStructure(
                                passwordController.text)) {
                              return "Example@1234";
                            }
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Password")),
                        ),
                        TextFormField(
                          controller: dobController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Date of Birth")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                          },
                          controller: genderController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Gender")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                          },
                          controller: educationController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Education")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                          },
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("phoneNumber")),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter Data";
                            }
                          },
                          controller: addressController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1)),
                              label: Text("Address")),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                logic.OnSignUp(
                                    nameController.text,
                                    emailController.text,
                                    passwordController.text,
                                    nameController.text,
                                    dobController.text,
                                    genderController.text,
                                    educationController.text,
                                    phoneNumberController.text,
                                    addressController.text,
                                    context);
                              }
                            },
                            child: Text("Register Data"))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
