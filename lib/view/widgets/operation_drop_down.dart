import 'package:flutter/material.dart';
import 'package:simplexe/controllers/home_controller.dart';
import 'package:simplexe/core/constants/enums.dart';

class OperationDropDown extends StatefulWidget {
  const OperationDropDown({
    Key? key,
    required this.controller,
    required this.index,
  }) : super(key: key);

  final HomeController controller;
  final int index;

  @override
  State<OperationDropDown> createState() => _OperationDropDownState();
}

class _OperationDropDownState extends State<OperationDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Operation>(
        value: widget.controller.operations[widget.index],
        items: const [
          DropdownMenuItem(
            value: Operation.le,
            child: Text("<="),
          ),
          DropdownMenuItem(
            value: Operation.ge,
            child: Text(">="),
          )
        ],
        onChanged: ((value) => setState(
            () => widget.controller.operations[widget.index] = value!)));
  }
}