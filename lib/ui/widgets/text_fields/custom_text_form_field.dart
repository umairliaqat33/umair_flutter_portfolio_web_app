import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:umair_liaqat/ui/widgets/text_fields/text_field_title.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final bool showFocusedColor;
  final String? hintText;
  final String label;
  final bool? asteriskRequired;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator? validator;
  final TextAlign textAlign;
  final bool fieldEnabled;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final bool isLabelGrey;
  final bool autoFocus;
  final Function? suffixIconFunction;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final bool? textFieldFilled;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIcon;
  final double? width;
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    required this.label,
    this.hintText,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.textAlign = TextAlign.left,
    this.fieldEnabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.isLabelGrey = false,
    this.autoFocus = false,
    this.suffixIconFunction,
    this.suffixIcon,
    this.onChanged,
    this.textFieldFilled = true,
    this.minLines = 1,
    this.asteriskRequired,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIconColor,
    this.showFocusedColor = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          label.isEmpty
              ? SizedBox()
              : TextFieldTitleWidget(
                  label: label,
                  asterisk: (asteriskRequired ?? false) ? "*" : null,
                ),
          label.isEmpty
              ? SizedBox()
              : SizedBox(
                  height: 6,
                ),
          TextFormField(
            style: TextStyle(
              // color: Colors.white,
              fontSize: 14,
            ),
            inputFormatters: inputFormatter,
            enabled: fieldEnabled,
            controller: controller,
            textInputAction: inputAction,
            keyboardType: inputType,
            textAlign: textAlign,
            validator: validator,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            autofocus: autoFocus,
            onChanged: (value) => onChanged == null ? null : onChanged!(value),
            onFieldSubmitted: (value) =>
                onFieldSubmitted == null ? null : onFieldSubmitted!(value),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              filled: textFieldFilled,
              fillColor: Colors.white,
              prefixIcon: prefixIcon,
              // prefixIconColor: fieldEnabled ? Colors.white : textFieldActiveColor,
              // suffixIcon: suffixIconFunction != null && suffixIcon != null
              //     ? IconButton(
              //         onPressed: () => suffixIconFunction!(),
              //         icon: CustomImageWidget(
              //           assetName: suffixIcon!,
              //           color: suffixIconColor,
              //         ),
              //       )
              //     : null,
              contentPadding: EdgeInsets.all(
                12,
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
                  color: showFocusedColor
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
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
                  color: Colors.grey.withValues(
                    alpha: 0.3,
                  ),
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
