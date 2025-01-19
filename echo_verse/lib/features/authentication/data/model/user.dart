
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
  final String? authId;

   UserModel(
      {this.name,
      required this.email,
      required this.password,
      this.authId,
      this.id = 0});
  factory UserModel.forLogin({
    required String email,
    required String password,
  }) {
    return UserModel(email: email, password: password);
  }

  factory UserModel.forRegistration({
    required String name,
    required String email,
    required String password,
    String? authId,
  }) {
    return UserModel(
        name: name, email: email, password: password, authId: authId);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auth_id': authId,
      'name': name,
      'email': email,
      'password': password,
      'id': id
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      authId: map['auth_id'],
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
      id: map['id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [name, email, password, authId, id];
}
