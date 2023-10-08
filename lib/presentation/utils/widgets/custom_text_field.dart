import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    required this.onChanged,
    this.hintText = '',
    this.errorMessage,
    this.initialValue,
    this.obscureText = false,
    this.controller,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.inputFormatters = const [],
    super.key,
  });

  final String label;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? errorMessage;
  final String? initialValue;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      textInputAction: textInputAction,
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        label: Text(label),
        isDense: true,
        hintText: hintText,
        errorText: errorMessage,
        errorMaxLines: 2,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
