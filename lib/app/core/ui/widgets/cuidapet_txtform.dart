// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:app_cuida_pet/app/core/ui/extensions/theme_extensions.dart';

class CuidapetTxtform extends StatelessWidget {
  final TextEditingController? controllerEC;
  final FormFieldValidator<String>? validator;
  final String labelText;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;

  CuidapetTxtform({
    Key? key,
    this.controllerEC,
    this.validator,
    required this.labelText,
    this.obscureText = false,
  }) : _obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _obscureTextVN,
      builder: (_, _obscureTextVNValue, child) {
        return TextFormField(
          controller: controllerEC,
          validator: validator,
          obscureText: _obscureTextVNValue,
          decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  gapPadding: 0 // Espaçamento entre o label e a linha da borda
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                gapPadding: 0,
                borderSide: const BorderSide(color: Colors.grey),
              ),
              suffixIcon: obscureText
                  ? IconButton(
                      onPressed: () {
                        _obscureTextVN.value = !_obscureTextVNValue;
                      },
                      icon: Icon(
                        _obscureTextVNValue ? Icons.lock : Icons.lock_open,
                        color: context.primaryColor,
                      ))
                  : null),
        );
      },
    );
  }
}
