import 'package:simplexe/core/classes/step.dart';
import 'package:simplexe/core/classes/table.dart';
import 'package:simplexe/core/constants/enums.dart';

import 'index.dart';

class Simplexe {
  Table table;
  Mode mode;
  List<String> vdb = [];

  Simplexe({required this.table, required this.mode}) {
    // Initialize tables
    if (mode == Mode.min) {
      for (var i = 0; i < table.fonctionObjective.length; i++) {
        table.fonctionObjective[i] = table.fonctionObjective[i] * -1;
      }
    }

    vdb = List.generate(table.contraints.length, (index) => "e${index + 1}");

    table.fonctionObjective
        .addAll(List.generate(table.contraints.length + 1, (_) => 0));

    List<List<double>> decarts = List.generate(
      table.contraints.length,
      (i) => List.generate(
          table.contraints.length,
          (j) => i == j ? table.operations[i] == Operation.le ? 1 : -1 : 0
      ),
    );

    for (var i = 0; i < table.contraints.length; i++) {
      table.contraints[i].addAll(decarts[i]);
      table.contraints[i].add(table.conts[i]);
    }

    steps.add(Step(table: table.deepCopy(), vdb: List.from(vdb)));
  }

  List<Step> steps = [];

  bool _canImprove() => table.fonctionObjective.any((element) => element > 0);

  Index _getPivot() {
    // get the index of 'variable entrent'
    double max = 0;
    int column = 0;

    for (int i = 0; i < table.fonctionObjective.length; i++) {
      if (table.fonctionObjective[i] > 0 && table.fonctionObjective[i] > max) {
        max = table.fonctionObjective[i];
        column = i;
      }
    }

    // get the index of 'variable sortant'
    List<double> rapports = [];

    for (int row = 0; row < table.contraints.length; row++) {
      rapports.add(table.contraints[row].last / table.contraints[row][column]);
    }

    double min = double.maxFinite;
    int row = 0;

    for (int i = 0; i < rapports.length; i++) {
      if (rapports[i] > 0 && rapports[i] < min) {
        min = rapports[i];
        row = i;
      }
    }

    return Index(row, column);
  }

  void solve() {
    while (_canImprove()) {
      Index pivotIndex = _getPivot();
      double pivot = table.contraints[pivotIndex.row][pivotIndex.column];
      int nmbrVariable =
          table.contraints.first.length - table.contraints.length - 1;

      for (var i = 0; i < table.contraints[pivotIndex.row].length; i++) {
        table.contraints[pivotIndex.row][i] =
            table.contraints[pivotIndex.row][i] / pivot;
      }

      for (int i = 0; i < table.contraints.length; i++) {
        if (pivotIndex.row != i) {
          List<double> pivotRowMultiple = table.contraints[pivotIndex.row]
              .map((e) => e * table.contraints[i][pivotIndex.column])
              .toList();
          table.contraints[i] = [
            for (int j = 0; j < nmbrVariable + table.contraints.length + 1; j++)
              table.contraints[i][j] - pivotRowMultiple[j]
          ];
        }
      }

      List<double> pivotRowMultiple = table.contraints[pivotIndex.row]
          .map((e) => e * table.fonctionObjective[pivotIndex.column])
          .toList();

      table.fonctionObjective = [
        for (int j = 0; j < nmbrVariable + table.contraints.length + 1; j++)
          table.fonctionObjective[j] - pivotRowMultiple[j]
      ];

      // Update Variable de base
      vdb[pivotIndex.row] = pivotIndex.column < nmbrVariable ? "x${pivotIndex.column+1}" : "e${pivotIndex.column-nmbrVariable+1}";

      steps.last.pivot = pivotIndex;
      steps.add(Step(table: table.deepCopy(), vdb: List.from(vdb)));
    }
  }
}
