import 'package:flutter/material.dart';
import 'package:simplexe/core/constants/regex.dart';

class NumberInputField extends StatelessWidget {
  const NumberInputField({
    Key? key,
    this.formKey,
    this.label,
    this.onChanged,
    this.isReal = true,
  }) : super(key: key);

  final String? label;
  final bool isReal;
  final void Function(String)? onChanged;
  final GlobalKey<FormState>? formKey;


  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: TextFormField(
        key: formKey,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            contentPadding: EdgeInsets.zero,
            labelText: label),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (value) => value.isNotEmpty ? onChanged!(value) : null,
        validator: ((value) {
          if (value == null || !(isReal ? numRegex.hasMatch(value) : intRegex.hasMatch(value))) return 'Invalid number';
          return null;
        }),
      ),
    );
  }
}
