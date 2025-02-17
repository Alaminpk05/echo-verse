import 'dart:io';

import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/settings/data/repository/setting_contract_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingService implements SettingContractServices {
  @override
  Future<User?> changeName(String newName) async {
    await firebaseAut.currentUser!.updateDisplayName(newName);
    await firebaseAut.currentUser!.reload();
    await firestore.collection('users').doc(userUid).update({'name': newName});
    return user;
  }

  @override
  Future<void> changeEmail(String password, String newEmail) async {
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );
    await user!.reauthenticateWithCredential(credential);

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

  @override
  Future<void> changeProfile() async {
    ImagePicker imagePicker = ImagePicker();

    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      File imageFile = File(file.path);
      Reference storageRef =
          firebaseStorage.ref().child('profileImages').child("$userUid.jpg");
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      await firebaseAut.currentUser!.updatePhotoURL(downloadUrl);
      await firestore.collection('users').doc(userUid).update({
        'imageUrl':downloadUrl
      });
    }
  }
}
