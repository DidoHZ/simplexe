import 'package:flutter/material.dart';
import 'package:simplexe/controllers/home_controller.dart';
import 'package:simplexe/core/constants/enums.dart';

class ModeDropDown extends StatefulWidget {
  const ModeDropDown({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  State<ModeDropDown> createState() => _ModeDropDownState();
}

class _ModeDropDownState extends State<ModeDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Mode>(
        value: widget.controller.mode,
        items: const [
          DropdownMenuItem(
            value: Mode.max,
            child: Text("Max"),
          ),
          DropdownMenuItem(
            value: Mode.min,
            child: Text("Min"),
          )
        ],
        onChanged: ((value) =>
            setState(() => widget.controller.mode = value!)));
  }
}