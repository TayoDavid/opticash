import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_text.dart';

void errorMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: AppText(
        message,
        color: Colors.white,
        family: "Poppins",
        size: 13,
      ),
    ),
  );
}
