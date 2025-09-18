import 'package:battleship/Nombre.dart';
import 'package:test/test.dart';

void main() {
  test('debe tener un minimo de longitud', () {
expect(()=> Nombre(''),throwsA(isA<LongitudMinimaException>()));
  }
  );
   test('debe tener un maximo de 15 de longitud', () {
expect(()=> Nombre('EsteNombreEsMuyLargo'),throwsA(isA<LongitudMaximaException>()));
  }
  );

  test('No debe tener caraceres especiales', () {
expect(()=> Nombre('Arturo##'),throwsA(isA<CaracteresInvalidosException>()));
  }
  );


}