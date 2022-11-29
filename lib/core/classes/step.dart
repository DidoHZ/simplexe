import 'package:simplexe/core/classes/index.dart';
import 'package:simplexe/core/classes/table.dart';

class Step {
  Table table;
  Index? pivot;
  List<String> vdb;

  Step({
    required this.table,
    required this.vdb,
    this.pivot,
  });
}
