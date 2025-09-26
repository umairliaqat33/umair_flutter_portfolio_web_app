// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:umair_liaqat/utils/app_strings.dart';
import 'package:umair_liaqat/utils/validator_utils.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    super.key,
    required this.controller,
    this.textFieldFilled = true,
    this.enabled = true,
    this.textVisible = true,
    this.label,
    this.hintText,
    this.inputAction = TextInputAction.done,
  });
  final TextEditingController controller;
  final bool? textFieldFilled;
  final bool enabled;
  final String? label;
  final String? hintText;
  bool textVisible;
  final TextInputAction inputAction;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldTitleWidget(
          label: widget.label ?? AppStrings.password,
          asterisk: "*",
        ),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          validator: (value) => ValidatorUtils.passwordValidator(value),
          textInputAction: widget.inputAction,
          obscureText: widget.textVisible,
          controller: widget.controller,
          enabled: widget.enabled,
          cursorColor: Colors.black,
          style: TextStyle(
            // color: Colors.white,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(
              12,
            ),
            filled: widget.textFieldFilled,
            fillColor: Colors.white,
            hintText: widget.hintText ??
                AppStrings.enterValue(AppStrings.password.toLowerCase()),
            hintStyle: TextStyle(
              // color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  widget.textVisible = !widget.textVisible;
                });
              },
              icon: widget.textVisible
                  ? Icon(
                      FontAwesomeIcons.solidEye,
                    )
                  : Icon(
                      FontAwesomeIcons.solidEyeSlash,
                    ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              borderSide: BorderSide(
                color: Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
