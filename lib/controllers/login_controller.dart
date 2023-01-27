import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/home_bottom_tab_bar.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;
  String? login(BuildContext context,String emailController,String passwordController)
  {
    auth.signInWithEmailAndPassword(email: emailController, password: passwordController).then((value){
      final snackBar = SnackBar(content: Text(value.user!.email.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.to(HomeBottomTabBar());
    }).onError((error, stackTrace){
      final snackBar = SnackBar(content: Text(error.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

  }
}
