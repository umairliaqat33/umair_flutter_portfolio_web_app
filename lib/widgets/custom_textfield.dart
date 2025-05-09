import 'package:flutter/material.dart';
import 'package:umair_liaqat_portfolio/utils/app_extensions.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Icon? prefix;
  final IconButton? suffixButton;
  final bool obscureText;
  final TextInputType textInputType;
  final Icon? suffix;
  final int? maxLines;
  final bool isPass;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomTextField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.prefix,
      this.suffixButton,
      this.textInputType = TextInputType.text,
      this.suffix,
      this.validator,
      this.isPass = false,
      this.maxLines,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      validator: validator,
      maxLines: maxLines,
      keyboardType: textInputType,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        suffix: suffixButton,
        hintText: hintText,
        hintStyle: textTheme.titleSmall,
        prefixIcon: prefix,
        suffixIcon: suffix,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.symmetric(
            vertical: 0.025 * context.height, horizontal: 0.02 * context.width),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
