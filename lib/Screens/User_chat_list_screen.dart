// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exd_social/Models/user_model.dart';
// import 'package:exd_social/Screens/chat_screen.dart';
// import 'package:exd_social/db/firebase_db.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:get/get.dart';
//
// class UserChatListScreen extends StatelessWidget {
//   const UserChatListScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(stream: FireStoreDB.getAllUsers(context),builder: (BuildContext context,  snapshot) {
//
//         return ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {
//           var detail = snapshot.data![index];
//           return ListTile(onTap: (){
//             final _user =  types.User(
//               id: detail.,
//               firstName:detail.name,
//               imageUrl: detail.profileImageUrl,
//             );
//             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//               return ChatScreen(receiverUser: _user,);
//             },));
//           },subtitle: Text("${detail.email}"),title: Text("${detail.name}"),
//           trailing: Icon(Icons.arrow_forward));
//         },);
//       },),
//     );
//   }
// }
