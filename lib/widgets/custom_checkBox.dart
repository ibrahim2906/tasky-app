import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (bool? value) => onChanged(value),
      activeColor: Color(0xff15BB6C),

      side: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 2),

    );
  }
}
