import 'package:flutter/material.dart';
import 'package:simplexe/controllers/home_controller.dart';
import 'package:simplexe/core/constants/regex.dart';

import 'input_field.dart';
import 'operation_drop_down.dart';

class Contraint extends StatelessWidget {
  const Contraint({
    Key? key,
    required this.index,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < controller.nmbrOfVariables; i++)
          Row(
            children: [
              SizedBox(
                  width: 50,
                  child: NumberInputField(
                      onChanged: (value) => controller.contraints[index][i] =
                          (value.isNotEmpty && numRegex.hasMatch(value)? double.parse(value) : 0)
                        )
              ),
              Text(" X${i + 1} + ")
            ],
          ),
        OperationDropDown(controller: controller, index: index),
        const SizedBox(width: 15),
        SizedBox(
            width: 50,
            child: NumberInputField(
                onChanged: (value) => controller.conts[index] =
                    (value.isNotEmpty && numRegex.hasMatch(value) ? double.parse(value) : 0)
                  )
        )
      ],
    );
  }
}