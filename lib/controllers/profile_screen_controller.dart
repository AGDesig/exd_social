import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class ProfileScreenController extends GetxController
{
  CollectionReference userReference = FirebaseFirestore.instance.collection("users");
  User? user = FirebaseAuth.instance.currentUser;
  String? urlImg, urlImg2;
  File? imageFile,imageFile2;

  getImageFromGallery(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
        uiSettings: [AndroidUiSettings(toolbarTitle: 'Profile Photo', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.square, lockAspectRatio: false),
          IOSUiSettings(title: 'Profile Photo',),
          WebUiSettings(context: context,),
        ],
      );
      if (croppedFile != null) {
        imageFile = File(croppedFile.path);
      }
      try {
        String uniqueName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        UploadTask? uploadTask;
        Reference storageRef = FirebaseStorage.instance.ref().child("UsersProfilePhoto").child("/$uniqueName");
        uploadTask = storageRef.putFile(File(imageFile!.path));
        await uploadTask.whenComplete(() => null);

        urlImg = await storageRef.getDownloadURL();
        CollectionReference firestoreInstance = FirebaseFirestore.instance.collection("users");
        User? user = FirebaseAuth.instance.currentUser;
        Map<String, dynamic> data = {"imageUrl": urlImg};

        firestoreInstance
            .doc(user!.uid)
            .update(data)
            .then((value) => print("Success!"));
        update();
      } catch (error) {
        print("error is big" + error.toString());
      }
    }
  }
  getImageFromGallery2(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square, CropAspectRatioPreset.ratio3x2, CropAspectRatioPreset.original, CropAspectRatioPreset.ratio4x3, CropAspectRatioPreset.ratio16x9],
        uiSettings: [AndroidUiSettings(toolbarTitle: 'Profile Photo', toolbarColor: Colors.deepOrange, toolbarWidgetColor: Colors.white, initAspectRatio: CropAspectRatioPreset.square, lockAspectRatio: false),
          IOSUiSettings(title: 'Profile Photo',),
          WebUiSettings(context: context,),
        ],
      );
      if (croppedFile != null) {
        imageFile2 = File(croppedFile.path);
      }
      try {
        String uniqueName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        UploadTask? uploadTask;
        Reference storageRef = FirebaseStorage.instance.ref().child("CoverPhotos").child("/$uniqueName");
        uploadTask = storageRef.putFile(File(imageFile2!.path));
        await uploadTask.whenComplete(() => null);

        urlImg2 = await storageRef.getDownloadURL();
        CollectionReference firestoreInstance = FirebaseFirestore.instance.collection("users");
        User? user = FirebaseAuth.instance.currentUser;
        Map<String, dynamic> data = {"metadata.coverImageUrl": urlImg2};

        firestoreInstance
            .doc(user!.uid)
            .update(data)
            .then((value) => print("Success!"));
        update();
      } catch (error) {
        print("error is big" + error.toString());
      }
    }
  }
}