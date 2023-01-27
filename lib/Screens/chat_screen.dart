import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final types.User receiverUser;
   ChatScreen({Key? key, required this.receiverUser}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  late types.User _user;


  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: _user.id,
        text: message.text,
        remoteId: widget.receiverUser.id);

    _addMessage(textMessage);
  }
  void _loadMessages() async {
    CollectionReference chatReference=FirebaseFirestore.instance.collection("chat");
    chatReference
        .where("remoteId", isEqualTo:widget.receiverUser.id)
        .where("author.id", isEqualTo: _user.id)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String,dynamic> docData=doc.data() as Map<String,dynamic>;
        _messages.insert(0,types.Message.fromJson(docData));
      }
      setState(() {

      });

    }).onError((error, stackTrace){
      print("$error");

    });
    setState(() {

    });
  }
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
    _addMessageToFirebase(message);
  }
  _addMessageToFirebase(types.Message message) async {
    CollectionReference chatReference =
    FirebaseFirestore.instance.collection("chat");

    chatReference.add(message.toJson());
  }
  loadCurrentUser() {
    User? fbCurrentUser = FirebaseAuth.instance.currentUser;
    _user =
        types.User(
          id: fbCurrentUser?.uid ?? "na",
          firstName: "Ali",
          imageUrl: "",
        );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCurrentUser();
    _loadMessages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Chat
      (
      messages: _messages,
      onSendPressed: _handleSendPressed,
      onPreviewDataFetched: _handlePreviewDataFetched,
      showUserAvatars: true,
      showUserNames: true,
      user: _user,),);
  }
}
