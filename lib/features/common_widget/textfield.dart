import 'package:ecommerce_dashboard/features/constants/constants.dart';
import 'package:flutter/material.dart';

class KpTextField extends StatelessWidget {
  const KpTextField(
      {Key? key,
      this.autoValidate = AutovalidateMode.onUserInteraction,
      this.label,
      this.hint,
      this.value,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.readonly = false,
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
  final String? value;
  final int? maxlines;
  final bool obscureText;
  final bool readonly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readonly,
      initialValue: value,
      maxLines: maxlines,
      obscureText: obscureText,
      cursorColor: const Color(0xFFFFA500),
      controller: controller,
      autovalidateMode: autoValidate,
      validator: validator,
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor)),
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
