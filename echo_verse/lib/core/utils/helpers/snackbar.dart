import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  snackBar(BuildContext context, final String messege,final ContentType type,final String title) {
     final snackbar=SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content:AwesomeSnackbarContent(title: title, message: messege, 
     contentType: type) );
 ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
