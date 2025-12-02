import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFAEDEFC);
  static final Color inputFillColor = primaryColor.withOpacity(0.12);
  static const Color scaffoldBackground = Color(0xFFF9F1F6);
  static const Color cardBackground = Color(0xFFF7EDF3);
  static const Color avatarBg = Color(0xFFBFE6F9);
  static const Color buttonTextColor = Colors.black;

  static ButtonStyle elevatedButtonStyle({Color? bg}) => ElevatedButton.styleFrom(
        backgroundColor: bg ?? primaryColor,
        foregroundColor: buttonTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

  static ButtonStyle outlinedButtonStyle({Color? fg}) => OutlinedButton.styleFrom(
        foregroundColor: fg ?? primaryColor,
        side: BorderSide(color: (fg ?? primaryColor).withOpacity(0.18)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      );

  static InputDecoration inputDecoration({required String label, IconData? prefixIcon}) => InputDecoration(
        labelText: label,
        filled: true,
        fillColor: inputFillColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        prefixIcon: prefixIcon == null ? null : Icon(prefixIcon, color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      );
}
