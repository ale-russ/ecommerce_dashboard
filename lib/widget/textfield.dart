import 'package:flutter/material.dart';

class KpTextField extends StatelessWidget {
  const KpTextField(
      {Key? key,
      this.autoValidate = AutovalidateMode.onUserInteraction,
      this.label,
      this.hint,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.suffixWidget,
      this.maxlines,
      TextStyle? labelStyle,
      String? hintText,
      TextStyle? hintStyle})
      : super(key: key);
  final AutovalidateMode autoValidate;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;
  final String? label;
  final String? hint;
  final int? maxlines;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxlines,
      obscureText: obscureText,
      cursorColor: const Color(0xFFFFA500),
      controller: controller,
      autovalidateMode: autoValidate,
      validator: validator,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFFA500), width: 1.5)),
          filled: true,
          // fillColor: Theme.of(context).colorScheme.onSecondary,
          fillColor: const Color.fromRGBO(255, 255, 255, 0.1),
          suffixIcon: suffixWidget,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
                //color: Colors.black,
                ),
          ),
          labelText: label,
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color.fromARGB(255, 149, 149, 149)),
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color.fromARGB(255, 149, 149, 149)),
          hintText: hint),
      style: const TextStyle(color: Colors.white),
    );
  }
}
