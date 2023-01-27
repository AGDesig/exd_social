import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/Screens/Friends/recieve_friend_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import '../../Models/user_model.dart';

class SendFriendRequest extends StatefulWidget {
  final UserModel detail;
  final String recieveid;
  const SendFriendRequest({Key? key, required this.recieveid, required this.detail,}) : super(key: key);

  @override
  State<SendFriendRequest> createState() => _SendFriendRequestState();
}

class _SendFriendRequestState extends State<SendFriendRequest> {


  Future<void> sendRequest() async {
    CollectionReference usersReference = FirebaseFirestore.instance.collection("users");
    User? user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> data = {
        "timestamp": Timestamp.now(),
        "status": "pending"
      };
      usersReference.doc(user!.uid).collection("friendRequests").doc(widget.recieveid).set(data);
  }


  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: Text("List of People"),
          actions: [
            TextButton(
              child: Text(
                "Recieve_Request",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RecieveFriendRequest(),
                ));
              },
            )
          ],
        ),
        body: SafeArea(
            child: Container(
                height: heightScreen,
                width: widthScreen,
                padding: EdgeInsets.only(top: 10),
                child: Container(
                  height: heightScreen,
                  width: widthScreen,
                  child: Column(children: [
                    Container(
                      color: Colors.amber,
                      height: heightScreen * 0.1,
                      width: widthScreen * 0.13,
                    ),
                    Text("${widget.detail.firstName}"),
                    ElevatedButton(
                        onPressed: () async {
                          await sendRequest();
                        },
                        child: Text("add Friends"))
                  ]),
                ),)));
  }
}
