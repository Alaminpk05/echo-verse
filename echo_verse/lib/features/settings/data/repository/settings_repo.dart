import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/settings/data/repository/setting_contract_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingService implements SettingContractServices {
  @override
  Future<void> changeName(String newName) async {
    await firebaseAut.currentUser!.updateDisplayName(newName);
    await firestore.collection('users').doc(userUid).update({'name': newName});
  }

  @override
  Future<void> changeEmail(String password, String newEmail) async {
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );
    await user!.reauthenticateWithCredential(credential);
    debugPrint('===============================>>>>>>>>>>>');
    debugPrint(user!.email.toString());
    debugPrint(credential.toString());

    await firebaseAut.currentUser!.verifyBeforeUpdateEmail(newEmail);
    await firestore
        .collection('users')
        .doc(userUid)
        .update({'email': newEmail});
  }

  @override
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    await firebaseAut.currentUser!.updatePassword(newPassword);
    await firestore
        .collection('users')
        .doc(userUid)
        .update({'email': newPassword});
  }
}
