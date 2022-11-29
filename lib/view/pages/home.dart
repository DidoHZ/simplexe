import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

import 'package:simplexe/controllers/home_controller.dart';
import 'package:simplexe/core/binding/result_binding.dart';
import 'package:simplexe/view/widgets/input_field.dart';
import 'package:simplexe/view/pages/result.dart';

import '../widgets/home_widgets.dart';

class Home extends GetView<HomeController> {
  const Home({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: NumberInputField(
                            label: 'Nombre variables',
                            isReal: false,
                            onChanged: controller.updateNumberOfVariables,
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                            width: 200,
                            child: NumberInputField(
                              label: 'Nombre des sous-contraints',
                              isReal: false ,
                              onChanged: controller.updateNumberOfContraints,
                            )),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GetBuilder<HomeController>(
                        init: HomeController(),
                        builder: ((controller) {
                          if (controller.nmbrOfVariables != 0 && controller.nmbrOfContraints != 0) {
                            return Column(
                              children: [
                                FonctionObjective(controller: controller),
                                for (int i = 0; i < controller.nmbrOfContraints; i++) 
                                ...[
                                  const SizedBox(height: 15),
                                  Contraint(index: i, controller: controller)
                                ],
                              const SizedBox(height: 30,),
                              TextButton(
                                    onPressed: () =>
                                      controller.contraints.any((element) => element.any((element) => element == null)) || controller.fonctionObjective.any((element) => element == null)
                                        ?  ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar( backgroundColor: Colors.redAccent, content: Text("Fill all fields")))
                                        :  Get.to(const ResultPage(), binding: ResultBinding(table: controller.getTable(), mode: controller.mode))
                                    ,
                                    child: const Text("Solve"))
                              ],
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Enter the variables above.")
                            ],
                          );
                        })),
                  ]),
            )));
  }
}
