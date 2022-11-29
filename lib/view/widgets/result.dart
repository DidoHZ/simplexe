import 'package:flutter/widgets.dart';
import 'package:simplexe/core/classes/step.dart';
import 'package:simplexe/core/classes/utils.dart';

class Result extends StatelessWidget {
  const Result({super.key, required this.step});
  final Step step;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: const Color.fromARGB(255, 0, 0, 0), width: 2),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
          const Text("v.d.b", textAlign: TextAlign.center),
          for (int i = 0; i < step.table.contraints.first.length - step.table.contraints.length - 1; i++) Text("X${i+1}", textAlign: TextAlign.center),
          for (int i = 0; i < step.table.contraints.length; i++) Text("e${i+1}", textAlign: TextAlign.center),
          const Text("Cont", textAlign: TextAlign.center),
        ]),
        for (int i = 0; i < step.table.contraints.length; i++)
          TableRow(
            children: [
              Text(step.vdb[i], textAlign: TextAlign.center),
              for (int j = 0; j < step.table.contraints[i].length; j++)
                Container(color: step.pivot != null && (i == step.pivot!.row && j == step.pivot!.column) ? const Color.fromARGB(255, 255, 0, 0) : null ,child: Text("${step.table.contraints[i][j].round() == step.table.contraints[i][j] ? step.table.contraints[i][j] : step.table.contraints[i][j] < 0 ? "-${toFraction(-step.table.contraints[i][j])}" : toFraction(step.table.contraints[i][j])}", textAlign: TextAlign.center))
          ]),
        TableRow(
          children: [
            const Text("Z", textAlign: TextAlign.center),
            for(var i in step.table.fonctionObjective)
              Text("${i.round() == i ? i : i < 0 ? "-${toFraction(-i)}" : toFraction(i)}", textAlign: TextAlign.center)
          ]
        )
      ],
    );
  }
}
