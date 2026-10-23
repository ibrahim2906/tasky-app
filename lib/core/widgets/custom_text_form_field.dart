import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.title,
    this.validator,
    required this.controller,
    required this.maxLines,
    required this.hint,
  });
final String title;
  final TextEditingController controller;
  final int maxLines;
  final String hint;
  final Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 15),
        ),
        SizedBox(height: 15,),
        TextFormField(
          controller: controller,
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,

          cursorColor: Theme.of(context).textTheme.labelMedium?.color,
          cursorErrorColor: CupertinoColors.destructiveRed,
          style: Theme.of(context).textTheme.labelMedium ,
          maxLines: maxLines,
          decoration: InputDecoration(
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            filled: true,
            hintText: hint,

            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none
            )
          ),
        ),
      ],
    );
  }
}
