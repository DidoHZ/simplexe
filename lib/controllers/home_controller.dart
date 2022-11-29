import 'package:get/state_manager.dart';
import 'package:simplexe/core/classes/table.dart';
import 'package:simplexe/core/classes/utils.dart';
import 'package:simplexe/core/constants/enums.dart';
import 'package:simplexe/core/constants/regex.dart';

class HomeController extends GetxController {
  int _nmbrOfContraints = 0;
  int _nmbrOfVariables = 0;
  Mode mode = Mode.max;
  List<double?> fonctionObjective = [];
  List<List<double?>> contraints = [];
  List<double?> conts = [];
  List<Operation> operations = [];

  set nmbrOfContraints(int? nmbr) {
    if (nmbr != null && nmbr >= 0) _nmbrOfContraints = nmbr;
  }

  int get nmbrOfContraints => _nmbrOfContraints;

  set nmbrOfVariables(int? nmbr) {
    if (nmbr != null && nmbr >= 0) _nmbrOfVariables = nmbr;
  }

  int get nmbrOfVariables => _nmbrOfVariables;

  void updateNumberOfContraints(String value) {
    nmbrOfContraints = (value.isNotEmpty && intRegex.hasMatch(value) ? int.parse(value) : null);
    initTable();
    update();
  }

  void updateNumberOfVariables(String value) {
    nmbrOfVariables = (value.isNotEmpty && intRegex.hasMatch(value) ? int.parse(value) : null);
    initTable();
    update();
  }

  void initTable() {
    if (_nmbrOfContraints != 0 && _nmbrOfVariables != 0) {
      fonctionObjective = combine(fonctionObjective, nmbrOfVariables);
      conts = combine(conts, _nmbrOfContraints);
      operations = combine(operations, _nmbrOfContraints, value: Operation.le).cast<Operation>();
      contraints = List.generate(_nmbrOfContraints,
          (index) => index < contraints.length ? combine(contraints[index], nmbrOfVariables) : List.generate(nmbrOfVariables, (index) => null));
    }
  }

  Table getTable() => Table(
      fonctionObjective: List.from(fonctionObjective),
      contraints: List.from(contraints.map<List<double>>((e) => List.from(e))),
      conts: List.from(conts),
      operations: List.from(operations));
}
