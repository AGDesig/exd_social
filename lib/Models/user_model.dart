import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.createdAt,
    required this.firstName,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.lastName,
    required this.lastSeen,
    required this.metadata,
    required this.role,
    required this.updatedAt,
    required this.lat,
    required this.lng,
  });
  late final String createdAt;
  late final String firstName;
  late final String imageUrl;
  late final String coverImageUrl;
  late final String lastName;
  late final String lastSeen;
  late final Metadata metadata;
  late final String role;
  late final String updatedAt;
  late final String lat;
  late final String lng;

  UserModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'].toString();
    firstName = json['firstName'];
    imageUrl = json['imageUrl'];
    coverImageUrl = json['coverImageUrl']??"nothing to show";
    lastName = json['lastName'] ?? "";
    lat = json['lat'] ?? "";
    lastSeen = json['lastSeen'].toString();
    metadata = Metadata.fromJson(json['metadata']);
    role = json['role'] ?? "";
    lng = json['lng'] ?? "";
    updatedAt = json['updatedAt'].toString();
  }

  UserModel.documentSnapshot(DocumentSnapshot snapshot) {
    createdAt = snapshot['createdAt'];
    firstName = snapshot['firstName'];
    imageUrl = snapshot['imageUrl'];
    coverImageUrl = snapshot['coverImageUrl'];
    lastName = snapshot['lastName'];
    lastSeen = snapshot['lastSeen'];
    lat = snapshot['lat'];
    lng = snapshot['lng'];
    metadata = Metadata.fromJson(snapshot['metadata']);
    role = snapshot['role'];
    updatedAt = snapshot['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['createdAt'] = createdAt;
    _data['firstName'] = firstName;
    _data['imageUrl'] = imageUrl;
    _data['lastName'] = lastName;
    _data['lastSeen'] = lastSeen;
    _data['metadata'] = metadata.toJson();
    _data['role'] = role;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Metadata {
  Metadata({
    required this.education,
    required this.email,
    required this.gender,
    required this.phone,
    required this.dateOfBirth,
    required this.coverImageUrl,
    required this.uid,
    required this.address,
  });
  late final String education;
  late final String email;
  late final String gender;
  late final String phone;
  late final String dateOfBirth;
  late final String coverImageUrl;
  late final String address;
  late final String uid;

  Metadata.fromJson(Map<String, dynamic> json) {
    education = json['education'];
    email = json['email'];
    gender = json['gender']??"";
    dateOfBirth = json['dateOfBirth'];
    phone = json['phone'];
    address = json['address'];
    uid = json['uid'];
    coverImageUrl = json['coverImageUrl'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['education'] = education;
    _data['email'] = email;
    _data['gender'] = gender;
    _data['dateOfBirth'] = dateOfBirth;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['coverImageUrl'] = coverImageUrl;
    _data['uid'] = uid;
    return _data;
  }
}