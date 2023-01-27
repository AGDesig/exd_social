import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/Screens/Friends/send_friend_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../Models/user_model.dart';

class RandomUsersList extends StatefulWidget {
  const RandomUsersList({Key? key}) : super(key: key);

  @override
  State<RandomUsersList> createState() => _RandomUsersListState();
}

class _RandomUsersListState extends State<RandomUsersList> {
  CollectionReference userReference = FirebaseFirestore.instance.collection("users");
  final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<UserModel>> getAllUsers() async* {
    List<UserModel> currentPostsList = [];
    await userReference.where('metadata.uid', isNotEqualTo: currentUserUid).get().then((QuerySnapshot snapshot) {
      for (var doc in snapshot.docs) {
        currentPostsList.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      }}).onError((error, stackTrace) {
      final snackBar = SnackBar(content: Text("${error}"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    yield currentPostsList;
  }

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(title: Text("List of recieve people")),
        body: SafeArea(
            child: StreamBuilder(
              stream: getAllUsers(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                else if(snapshot.hasError)
                  {
                    return Center(child: Text("${snapshot.error}"),);
                  }
                else if (snapshot.connectionState == ConnectionState.done)
                  {
                    return Container(
                        height: heightScreen,
                        width: widthScreen,
                        padding: EdgeInsets.only(top: 10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,crossAxisSpacing: 3),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final detail = snapshot.data![index];
                            return Container(
                              height: heightScreen,
                              width: widthScreen,
                              child: Column(children: [
                                Container(
                                  color: Colors.amber,
                                  height: heightScreen * 0.1,
                                  width: widthScreen * 0.13,
                                ),
                                Text("${detail.firstName}"),
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SendFriendRequest(recieveid: detail.metadata.uid, detail: snapshot.data![index],),));
                                    }, child: Text("check profile"))
                              ]),
                            );
                          },
                        ));
                  }
                return Text("");

              }
            )));
  }
}
