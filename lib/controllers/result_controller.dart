import 'package:get/get.dart';
import 'package:simplexe/core/classes/simplexe.dart';

import 'package:simplexe/core/classes/table.dart';
import 'package:simplexe/core/constants/enums.dart';

class ResultController extends GetxController {
  ResultStatus status = ResultStatus.init;
  late Simplexe simplexe;

  Table table;
  Mode mode;

  ResultController({required this.table, required this.mode}) {
    simplexe = Simplexe(table: table, mode: mode);
  }

  Future<void> solve() async {
    _setState(() => status = ResultStatus.solving);

    simplexe.solve();

    _setState(() => status = ResultStatus.solved);
  }

  _setState(Function function, {List<Object>? ids}) {
    function();
    update(ids);
  }
}
