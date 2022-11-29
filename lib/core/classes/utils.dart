import 'dart:math';

/// Convert number to fraction.
String toFraction(num num) {
  var tolerance = 1.0E-6;
  var h1 = 1; var h2 = 0;
  var k1 = 0; var k2 = 1;
  var b = num;
  do {
    var a = b.floor();
    var aux = h1;
    h1 = a * h1 + h2;
    h2 = aux;
    aux = k1;
    k1 = a * k1 + k2;
    k2 = aux;
    b = 1 / (b - a);
  } while ((num - h1 / k1).abs() > num * tolerance);

  return "$h1/$k1";
}

List<T?> combine<T>(List<T?> a, int lenB, {T? value}){
  List<T?> tmp = List.generate(lenB, (index) => value);

  for (var i = 0; i < min(tmp.length, a.length); i++) {
        tmp[i] = a[i];
  }
  
  return tmp;
}