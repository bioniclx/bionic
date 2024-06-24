import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  required IconData icon,
  required Color backgroundColor,
  required Color textColor,
  required Color borderColor,
}) {
  Get.snackbar(
    '',
    '',
    titleText: Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    messageText: Text(
      message,
      style: TextStyle(color: textColor),
    ),
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
    borderRadius: 12,
    margin: const EdgeInsets.all(16),
    isDismissible: true,
    duration: const Duration(seconds: 3),
    borderColor: borderColor,
    borderWidth: 1,
    icon: IconButton(
      icon: Icon(Icons.close, color: textColor),
      onPressed: () {
        Get.back();
      },
    ),
  );
}

void showSuccessSnackbar(title, message) {
  showCustomSnackbar(
      title: title,
      message: message,
      icon: Icons.check_circle,
      backgroundColor: const Color(0xFFE6F4EA),
      textColor: const Color(0xFF2E7D32),
      borderColor: const Color(0xFF9FDFA2));
}

void showInformationSnackbar(title, message) {
  showCustomSnackbar(
      title: title,
      message: message,
      icon: Icons.info,
      backgroundColor: const Color(0xFFE8F4FD),
      textColor: const Color(0xFF1976D2),
      borderColor: const Color(0xFF90CAF9));
}

void showWarningSnackbar(title, message) {
  showCustomSnackbar(
      title: title,
      message: message,
      icon: Icons.warning,
      backgroundColor: const Color(0xFFFFF4E5),
      textColor: const Color(0xFFF57C00),
      borderColor: const Color(0xFFFFE0B2));
}

void showErrorSnackbar(title, message) {
  showCustomSnackbar(
      title: title,
      message: message,
      icon: Icons.error,
      backgroundColor: const Color(0xFFFDECEA),
      textColor: const Color(0xFFD32F2F),
      borderColor: const Color(0xFFEF9A9A));
}
