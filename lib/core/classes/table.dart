import 'package:simplexe/core/constants/enums.dart';

class Table {
  Table(
      {required this.fonctionObjective,
      required this.contraints,
      required this.conts,
      required this.operations});

  List<double> fonctionObjective;
  List<List<double>> contraints;
  List<double> conts;
  List<Operation> operations;

  Table deepCopy() => Table(
    fonctionObjective: List.from(fonctionObjective), 
    contraints: List.from(contraints.map<List<double>>((contraint) => List.from(contraint))), 
    conts: List.from(conts),
    operations: List.from(operations)
  );
}
