import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.postText,
    required this.uid,
    required this.userImage,
    required this.userName,
    required this.postImage,
    required this.dateTime,
    required this.likesCount,
    required this.commentsCount,
  });

  PostModel.withoutId({
    required this.postText,
    required this.uid,
    required this.userImage,
    required this.postImage,
    required this.dateTime,
    required this.likesCount,
    required this.commentsCount,
    required this.userName,
  });

  late final String id;
  late final String postText;
  late final String uid;
  late final String userImage;
  late final String userName;
  late final String postImage;
  late final String dateTime;
  late final int likesCount;
  late final int commentsCount;

  PostModel.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    postText = json['postText'];
    uid = json['uid'];
    userImage = json['userImage'];
    userName = json['userName'];
    postImage = json['postImage'];
    dateTime = json['dateTime'];
    likesCount = json['likesCount'];
    commentsCount = json['commentsCount'];
  }

  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    postText = documentSnapshot['postText'] ?? "";
    uid = documentSnapshot['uid'] ?? "";
    userImage = documentSnapshot['userImage'] ?? "";
    userName = documentSnapshot['userName'] ?? "";
    postImage = documentSnapshot['postImage'] ?? "";
    dateTime = documentSnapshot['dateTime'] ?? DateTime.now().toString();
    likesCount = documentSnapshot['likesCount'] ?? 0;
    commentsCount = documentSnapshot['commentsCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['postText'] = postText;
    _data['uid'] = uid;
    _data['userImage'] = userImage;
    _data['userName'] = userName;
    _data['postImage'] = postImage;
    _data['dateTime'] = dateTime;
    _data['likesCount'] = likesCount;
    _data['commentsCount'] = commentsCount;
    return _data;
  }
}
