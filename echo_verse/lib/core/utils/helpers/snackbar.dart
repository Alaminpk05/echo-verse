import 'package:flutter/material.dart';

class CustomSnackbar {
  snackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      showCloseIcon: true,
      
        content: Text(
      text,
      softWrap: true,
      style: Theme.of(context).textTheme.labelLarge,
    )));
  }
}
