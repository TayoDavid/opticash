import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_text.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.suffix,
    this.obscureText = false,
  });
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final Widget? suffix;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: AppText(
            label,
            size: 11,
            family: "Poppins",
            color: Color(0xFF9E9E9E),
          ),
        ),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelStyle: TextStyle(),
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Color(0xFF46531F), width: 1.5),
        ),
      ),
    );
  }
}
