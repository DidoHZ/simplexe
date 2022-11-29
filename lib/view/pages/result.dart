import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simplexe/controllers/result_controller.dart';
import 'package:simplexe/core/constants/enums.dart';
import 'package:simplexe/view/widgets/result.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResultController controller = Get.find();

  @override
  void initState() {
    controller.solve();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simplexe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
          init: controller,
          builder: (controller) =>
            controller.status == ResultStatus.solved
              ? ListView(
                children: [
                  for (var step in controller.simplexe.steps) ...[
                    Result(step: step),
                    const SizedBox(
                      height: 20,
                    )
                  ]
                ],
              )
             :  const Center(child: CircularProgressIndicator.adaptive())
          ,
        ),
      ),
    );
  }
}
