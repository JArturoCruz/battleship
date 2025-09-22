import 'package:battleship/Nombre.dart';
import 'package:test/test.dart';

void main() {
  test('debe tener un minimo de longitud', () {
expect(()=> Nombre(''),throwsA(isA<ErrorLongitudMinima>()));
  }
  );
   test('debe tener un maximo de 15 de longitud', () {
expect(()=> Nombre('EsteNombreEsMuyLargooooooooooooooooooo'),throwsA(isA<ErrorLongitudMaxima>()));
  }
  );

  test('No debe tener caraceres especiales', () {
expect(()=> Nombre('Arturo##'),throwsA(isA<ErrorCaracterInvalido>()));
  }
  );

  test('No debe empezar con numero', () {
expect(()=> Nombre('19Arturo'),throwsA(isA<ErrorCaracterInvalido>()));
  }
  );

    test('Permite caracteres normales', () {
Nombre nombre = Nombre("Arturo");
expect(true,equals(true));
  }
  );

    test('nombre con ñ', () {
Nombre nombre = Nombre("ñoño69");
expect(true,equals(true));
  }
  );
}