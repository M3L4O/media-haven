import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/mh_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.controller,
    this.obscureText = false,
    this.inputFormatters,
    this.keyboardType,
    this.validator,
  });

  final String labelText;
  final String hintText;
  final IconData icon;
  final Function(String) onChanged;
  final TextEditingController controller;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: MHColors.blue,
      obscureText: obscureText,
      inputFormatters: inputFormatters ?? [],
      keyboardType: keyboardType ?? TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
        fillColor: MHColors.lightGray,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        hintText: hintText,
        label: Text(labelText),
        prefixIcon: Icon(
          icon,
          color: MHColors.blue,
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: MHColors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: MHColors.lightGray,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: MHColors.blue,
          ),
        ),
      ),
    );
  }
}
