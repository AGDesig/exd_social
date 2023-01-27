import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/Screens/login.dart';
import 'package:exd_social/Screens/login_screen.dart';
import 'package:exd_social/db/firebase_db.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../Models/user_model.dart';

class FirebaseAuthentication {
  static CollectionReference userReference =
  FirebaseFirestore.instance.collection("users");
  static Future<bool> signupUser(
      {required UserModel data, required String password, required BuildContext context}) async {
    bool status = false;
    String? token=await FirebaseMessaging.instance.getToken();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: data.metadata.email,
        password: password,
      );
      User? currentUser = credential.user;
      DocumentReference currentUserReference =
      userReference.doc(currentUser!.uid);
      Map<String, dynamic> metaData= {
        "email":data.metadata.email,
        "phone":data.metadata.phone,
        "education":data.metadata.education,
        "dateOfBirth":data.metadata.dateOfBirth,
        "address":data.metadata.address,
        "coverImageUrl":data.metadata.coverImageUrl,
        "uid" : currentUser.uid,
      };
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: data.firstName,
          id: credential.user!.uid,
          imageUrl: data.imageUrl,
          metadata: metaData
        ),
      );
      DocumentReference userRef=FirebaseFirestore.instance.collection("users").doc(currentUser.uid??"");
      await userRef.update({"firebaseToken":token});
      // FireStoreDB.addUserProfile(
      //   data: data,
      //   credential: credential,
      // );
      final snackbar = SnackBar(content: Text("data has been registered"));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Get.to(LoginScreen());
      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackBar = SnackBar(content: Text("${e.code}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(content: Text("${e.code}"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      print(e);
    }
    return status;
  }


}
