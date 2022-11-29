import 'package:get/get.dart';
import 'package:simplexe/controllers/result_controller.dart';
import 'package:simplexe/core/classes/table.dart';
import 'package:simplexe/core/constants/enums.dart';

class ResultBinding implements Bindings {
  final Table table;
  final Mode mode;

  const ResultBinding({required this.table, required this.mode});

  @override
  void dependencies() {
    Get.lazyPut<ResultController>(() => ResultController(table: table, mode: mode));
  }
}
