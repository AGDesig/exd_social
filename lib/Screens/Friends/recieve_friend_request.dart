import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RecieveFriendRequest extends StatefulWidget {
  const RecieveFriendRequest({Key? key}) : super(key: key);

  @override
  State<RecieveFriendRequest> createState() => _RecieveFriendRequestState();
}

class _RecieveFriendRequestState extends State<RecieveFriendRequest> {
  CollectionReference friendRequestReference = FirebaseFirestore.instance.collection("users");
  final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.blue,
        appBar: AppBar(title: Text("List of recieve people")),
        body: SafeArea(
            child: StreamBuilder<QuerySnapshot>(
              stream: friendRequestReference.where("metadata.friendsRequests.reciever_uid", isEqualTo: currentUserUid).snapshots(),
              builder: (context, snapshot) {
                return Container(
                    height: heightScreen,
                    width: widthScreen,
                    padding: EdgeInsets.only(top: 10),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,crossAxisSpacing: 3),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot  detail = snapshot.data!.docs[index];
                        return Container(
                          height: heightScreen,
                          width: widthScreen,
                          child: Column(children: [
                            Container(
                              color: Colors.amber,
                              height: heightScreen * 0.1,
                              width: widthScreen * 0.13,
                            ),
                            Text("${detail['metadata.friendsRequests.reciever_uid']}"),
                            ElevatedButton(
                                onPressed: null, child: Text("Accept Request"))
                          ]),
                        );
                      },
                    ));
              }
            )));
  }
}
