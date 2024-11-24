import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackbar({
    required BuildContext context,
    required String message,
    Color backgroundColor = const Color(0xFF0F0F0F),
    Duration duration = const Duration(seconds: 3),
    TextStyle textStyle = const TextStyle(color: Colors.white, fontSize: 16),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor.withOpacity(0.9),
        duration: duration,
        content: Center(
          child: Text(
            message,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
