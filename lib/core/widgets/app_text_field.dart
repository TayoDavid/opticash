import 'package:flutter/material.dart';
import 'package:opticash/core/widgets/app_text.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.suffix,
    this.validate,
    this.onChanged,
    this.focusNode,
    this.obscureText = false,
    this.type,
    this.action,
    this.onFieldSubmitted,
  });
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final Widget? suffix;
  final bool obscureText;
  final String? Function(String?)? validate;
  final void Function(String?)? onChanged;
  final TextInputType? type;
  final TextInputAction? action;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText,
      validator: validate,
      onChanged: onChanged,
      keyboardType: type,
      textInputAction: action,
      onFieldSubmitted: onFieldSubmitted,
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
        suffixIconColor: Color(0xff9e9e9e),
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
