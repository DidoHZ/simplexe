import 'package:flutter/material.dart';
import 'package:simplexe/controllers/home_controller.dart';
import 'package:simplexe/core/constants/regex.dart';

import 'input_field.dart';
import 'mode_drop_down.dart';

class FonctionObjective extends StatelessWidget {
  const FonctionObjective({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ModeDropDown(controller: controller),
        const SizedBox(width: 20),
        for (int i = 0; i < controller.nmbrOfVariables; i++)
          Row(
            children: [
              SizedBox(
                  width: 50,
                  child: NumberInputField(
                      onChanged: (value) => controller.fonctionObjective[i] =
                          (value.isNotEmpty && numRegex.hasMatch(value)
                              ? double.parse(value)
                              : 0))),
              Text(
                  " X${i + 1}${i != controller.nmbrOfVariables - 1 ? " + " : ""}")
            ],
          )
      ],
    );
  }
}