import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import '../Auth/firebase_auth.dart';
import '../Models/user_model.dart';

class SignupScreenController extends GetxController
{
  String? validateName(String? value) {
    if(value == null || value.isEmpty)
      {
        return "please Enter Text";
      }
    if(value.length <= 10)
      {
        return "Enter atleast 10 characters";
      }
  }
  String? validateEmail(String? value) {
    if(value == null || value.isEmpty)
      {
        return "please Enter Text";
      }
    if(value.length <= 10)
      {
        return "Enter atleast 10 characters";
      }
  }
  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
  String? validateAddress(String? value) {
    if(value == null || value.isEmpty)
      {
        return "please Enter Text";
      }
    if(value.length <= 10)
      {
        return "Enter atleast 10 characters";
      }
  }
  bool validatePhoneNumber(String value) {
    String pattern =
        r"^(?:\+92|0)[-\s]?(?:\d{3})[-\s]?\d{7}$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

 String? OnSignUp(
     String nameController,
     String emailController,
     String passwordController,
     String NameController,
     String dobController,
     String genderController,
     String educationController,
     String phoneNumberController,
     String addressController,
     BuildContext context,
     )
  {
    FirebaseAuthentication.signupUser(
      data: UserModel(
          createdAt: "${DateTime.now()}",
          firstName: nameController,
          imageUrl: "",
          lastName: "",
          lastSeen: "${DateTime.now()}",
          metadata: Metadata(
              dateOfBirth: dobController,
              education: educationController,
              email: emailController,
              gender: genderController,
              phone: phoneNumberController,
              coverImageUrl: "",
              address: addressController, uid: ''),
          role: "",
          updatedAt: "${DateTime.now()}",
          coverImageUrl: '',
          lat: '',
          lng: '',),
      password: passwordController,
      context: context,);
    return null;
  }

}