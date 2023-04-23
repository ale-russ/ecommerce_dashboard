// ignore: must_be_immutable
import 'package:ecommerce_dashboard/common_widget/textfield.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmailPasswordFields extends StatelessWidget {
  EmailPasswordFields({
    super.key,
    this.icon,
    this.obscureText = false,
    required this.hint,
    required this.controller,
    this.validator,
  });

  Widget? icon;
  bool obscureText;
  String hint;

  String? Function(String?)? validator;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: KpTextField(
        validator: validator,
        controller: controller,
        hint: hint,
        maxlines: 1,
        obscureText: obscureText,
        suffixWidget: icon,
      ),
    );
  }
}
