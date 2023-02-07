import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/Models/user_model.dart';
import 'package:exd_social/Screens/login_screen.dart';
import 'package:exd_social/controllers/profile_screen_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var widthScreen = Get.width;
    var heightScreen = Get.height;
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProfileScreenController>(
            init: ProfileScreenController(), builder: (logic) {
          return FutureBuilder<DocumentSnapshot>(
            future: logic.userReference.doc(user!.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel details = UserModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 350, left: 20, right: 20, bottom: 20),
                        color: Colors.black12,
                        height: heightScreen,
                        width: widthScreen,
                        child: Container(decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadiusDirectional.circular(10)),
                          child: Wrap(direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              alignment: WrapAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text("Name: ${details.firstName}",
                                    style: TextStyle(fontSize: 20),),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text("Email: ${details.metadata.email} ",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                      "Phone Number:${details.metadata.phone}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, left: 20),
                                  child: Text("Address:${details.metadata.address}",
                                      style: TextStyle(fontSize: 20)),
                                ),
                                Container(child: IconButton(onPressed:() => showDialog(context: context, builder: (context) => SimpleDialog(title: Text("Logout"),children: [Text("are you sure you want to logout"),TextButton(onPressed: ()async{await FirebaseAuth.instance.signOut();Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(),));}, child: Text("Yes"))]),),icon: Icon(Icons.logout),),)
                              ]),
                        ),
                      ),
                      GetBuilder<ProfileScreenController>(builder: (logic3) {
                        return Container(alignment: Alignment.bottomRight,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(details.metadata.coverImageUrl),
                                    fit: BoxFit.cover)),
                            height: heightScreen * 0.3,
                            width: widthScreen,
                            child: IconButton(
                        onPressed: () async {
                              await logic3.getImageFromGallery2(context);
                            }, icon: Icon(Icons.edit,size: 40),));
                      }),
                      Positioned(
                          left: 10,
                          top: 180,
                          child: GetBuilder<ProfileScreenController>(
                              builder: (logic2) {
                                return ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                details.imageUrl),
                                            fit: BoxFit.fill)),
                                    width: widthScreen * 0.3,
                                    height: heightScreen * 0.17,
                                    padding: EdgeInsets.only(left: 60, top: 70),
                                    child: IconButton(
                                        color: Colors.black54,
                                        onPressed: () async {
                                          await logic2.getImageFromGallery(
                                              context);
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          size: 40,
                                        )),
                                  ),);
                              })),
                      Positioned(
                          top: 260,
                          left: 180,
                          child: Container(
                              decoration: BoxDecoration(color: Colors
                                  .black38,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10)),

                              child: Text(
                                " ${details.firstName}",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              )))
                    ],
                  );
                }
              }
              return Text("");
            },
          );
        }),
      ),
    );
  }
}
