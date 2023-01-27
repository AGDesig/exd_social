import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Models/PostModel.dart';
import '../Models/CommentModel.dart';
import '../Models/user_model.dart';

class FireStoreDB {
  static CollectionReference commentReference = FirebaseFirestore.instance.collection("Comments");
  static CollectionReference userReference =
  FirebaseFirestore.instance.collection("users");
  static CollectionReference Postreference = FirebaseFirestore.instance.collection("ListOfPosts");

  static Future<bool> addUserProfile(
      {required UserModel data, required final credential}) async {
    User? currentUser = credential.user;
    try{
      if (currentUser != null) {
        DocumentReference currentUserReference =
        userReference.doc(currentUser.uid);
        Map<String, dynamic> userProfileData = {
          "name": data.firstName,
          "email": data.metadata.email,
          "uid": currentUser.uid,
          "dob": data.metadata.dateOfBirth,
          "gender": data.metadata.gender,
          "education": data.metadata.education,
          "profileImageUrl": data.imageUrl,
          "coverImageUrl": data.coverImageUrl,
          "dateCreate": data.createdAt,
          "dateUpdate": data.updatedAt,
          "phoneNumber": data.metadata.phone,
          "lat": data.metadata,
          "lng": data.lng,
          "address": data.metadata.address,
        };
        currentUserReference.set(userProfileData);
      }
      return true;
    } on Exception catch (e)
    {
      return false;
    }
  }
  static addPostdata({required PostModel data,}) async
  {
    User? currentUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> postData = {
      "title" : data.postImage,
      "body" : data.postImage,
      "uid" : currentUser!.uid,
    };
    Postreference.add(postData);
  }
  static addComments({required CommentModel detail}) async {

    User? currentUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      "text" : detail.text,
      "uid" : currentUser!.uid,
      "postid" : detail.postid
    };
    commentReference.add(data);
  }

  static Stream<List<UserModel>> getAllUsers(BuildContext context) async* {
    List<UserModel> currentPostsList = [];
    await userReference.get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        Map<String, dynamic> docdata = doc.data() as Map<String, dynamic>;
        currentPostsList.add(UserModel.fromJson(docdata));
      }}).onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text("${error}"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    yield currentPostsList;

  }

}