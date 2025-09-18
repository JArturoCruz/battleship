import 'package:battleship/Nombre.dart';
import 'package:test/test.dart';

void main() {
  test('debe tener un minimo de longitud', () {
expect(()=> Nombre(''),throwsA(isA<LongitudMinimaException>()));
  }
  );

}