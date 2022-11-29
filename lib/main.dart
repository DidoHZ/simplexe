import 'package:flutter/material.dart';
import 'package:simplexe/core/binding/home_binding.dart';
import 'package:simplexe/view/pages/home.dart';
import 'package:get/get.dart';

void main() {
  runApp(const Simplexe());
}

class Simplexe extends StatelessWidget {
  const Simplexe({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simplexe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      initialBinding: HomeBinding(),
      home: Home(title: 'Simplexe'),
    );
  }
}
