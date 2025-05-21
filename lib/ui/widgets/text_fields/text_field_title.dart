import 'package:flutter/material.dart';

class TextFieldTitleWidget extends StatelessWidget {
  final String label;
  final String? asterisk;
  const TextFieldTitleWidget({
    super.key,
    required this.label,
    this.asterisk,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        asterisk == null
            ? const SizedBox()
            : Text(
                asterisk!,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
      ],
    );
  }
}
