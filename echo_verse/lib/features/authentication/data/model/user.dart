// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
// ignore: must_be_immutable
class UserModel extends Equatable {
  @Id()
  int id;
  final String? name;
  final String email;
  final String password;
  String? authId;
  String? createdAt;
  bool isOnline;
  String? lastActive;
  String? pushToken;
  String? imageUrl;

  UserModel({
    this.id = 0,
    required this.email,
    required this.password,
    this.name,
    this.authId,
    this.createdAt,
    this.isOnline = false,
    this.lastActive,
    this.pushToken,
    this.imageUrl,
  });

  ///LOGIN
  factory UserModel.forLogin({
    required String email,
    required String password,
  }) =>
      UserModel(email: email, password: password);

  ///  REGISTRATION
  factory UserModel.forRegistration({
    required String name,
    required String email,
    required String password,
    required String? authId,
    required String? createdAt,
    required bool isOnline,
    required String? lastActive,
    required String? pushToken,
    String? imageUrl,
  }) =>
      UserModel(
        name: name,
        email: email,
        password: password,
        authId: authId,
        createdAt: createdAt,
        isOnline: isOnline = false,
        lastActive: lastActive,
        pushToken: pushToken,
        imageUrl:imageUrl,
      );

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] ?? 0,
        name: map['name'],
        email: map['email'],
        password: map['password'],
        authId: map['authId'],
        createdAt: map['createdAt'],
        isOnline: map['isOnline'],
        lastActive: map['lastActive'],
        pushToken: map['pushToken'],
        imageUrl: map['imageUrl']

      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'authId': authId,
        'createdAt': createdAt,
        'isOnline': isOnline,
        'lastActive': lastActive,
        'pushToken': pushToken,
        'imageUrl':imageUrl
      };

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        password,
        authId,
        createdAt,
        isOnline,
        lastActive,
        pushToken,
        imageUrl,
      ];
}
