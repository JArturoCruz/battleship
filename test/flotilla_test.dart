import 'package:battleship/coordenada.dart';
import 'package:battleship/flotilla.dart';
import 'package:test/test.dart';

void main() {
  group('Flotilla', () {
    // Coordenadas de ejemplo para no repetirlas en cada test
    const c00 = Coordenada(fila: 0, columna: 0);
    const c20 = Coordenada(fila: 2, columna: 0); const c21 = Coordenada(fila: 2, columna: 1);
    const c40 = Coordenada(fila: 4, columna: 0); const c42 = Coordenada(fila: 4, columna: 2);
    const c60 = Coordenada(fila: 6, columna: 0); const c63 = Coordenada(fila: 6, columna: 3);
    const c80 = Coordenada(fila: 8, columna: 0); const c84 = Coordenada(fila: 8, columna: 4);

    test('debe tener 5 tipos diferentes de barcos al crearse', () {
      final barcos = [
        Barco(tipo: TiposBarcos.bote,       inicio: c00, fin: c00),
        Barco(tipo: TiposBarcos.lancha,     inicio: c20, fin: c21),
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      final flotilla = Flotilla(barcos);
      expect(flotilla.cantidad, equals(5));
    });

    test('debe lanzar una excepción si hay tipos de barcos repetidos', () {
      final barcosConRepetidos = [
        Barco(tipo: TiposBarcos.bote,       inicio: c00, fin: c00),
        Barco(tipo: TiposBarcos.bote,       inicio: c20, fin: c20), // Repetido
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosConRepetidos),
          throwsA(isA<FlotillaBarcosRepetidosException>()));
    });

    test('debe lanzar una excepción si tiene menos de 5 barcos', () {
      final barcosMenos = [Barco(tipo: TiposBarcos.bote, inicio: c00, fin: c00)];
      expect(
          () => Flotilla(barcosMenos), throwsA(isA<FlotillaCantidadException>()));
    });

    test('debe lanzar una excepción si tiene más de 5 barcos', () {
      final barcosMas = [
        Barco(tipo: TiposBarcos.bote,       inicio: c00, fin: c00),
        Barco(tipo: TiposBarcos.lancha,     inicio: c20, fin: c21),
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84),
        Barco(tipo: TiposBarcos.bote,       inicio: Coordenada(fila: 10, columna: 0), fin: Coordenada(fila: 10, columna: 0)) // Barco extra
      ];
      expect(
          () => Flotilla(barcosMas), throwsA(isA<FlotillaCantidadException>()));
    });

    test('debe lanzar una excepción si un barco está en diagonal', () {
      expect(() => Barco(tipo: TiposBarcos.lancha, inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 1, columna: 1)),
          throwsA(isA<BarcoPosicionDiagonalException>()));
    });

    test('debe lanzar una excepción si el tamaño del barco no coincide con sus coordenadas', () {
      expect(() => Barco(tipo: TiposBarcos.crucero, inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 0, columna: 1)),
          throwsA(isA<BarcoTamanoIncorrectoException>()));
    });

    test('debe lanzar una excepción si los barcos están juntos (superpuestos)', () {
      final barcosJuntos = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 0, columna: 0)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 0, columna: 1), fin: const Coordenada(fila: 0, columna: 2)), // Adyacente
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntos),
          throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });

    test('debe lanzar una excepción si los barcos están juntos en diagonal', () {
      final barcosJuntosDiagonal = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 0, columna: 0)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 1, columna: 0), fin: const Coordenada(fila: 1, columna: 1
        )), // Adyacente en diagonal
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntosDiagonal),
          throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });

    test('debe lanzar excepción si un barco está adyacente a la derecha de otro', () {
      final barcosJuntos = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 0, columna: 0)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 0, columna: 1), fin: const Coordenada(fila: 0, columna: 2)), // Adyacente a la derecha
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntos), throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });

    test('debe lanzar excepción si un barco está adyacente a la izquierda de otro', () {
      final barcosJuntos = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 0, columna: 3), fin: const Coordenada(fila: 0, columna: 3)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 0, columna: 1), fin: const Coordenada(fila: 0, columna: 2)), // Adyacente a la izquierda
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntos), throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });

    test('debe lanzar excepción si un barco está adyacente arriba de otro', () {
      final barcosJuntos = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 0, columna: 0), fin: const Coordenada(fila: 0, columna: 0)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 1, columna: 0), fin: const Coordenada(fila: 2, columna: 0)), // Adyacente abajo
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntos), throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });

    test('debe lanzar excepción si un barco está adyacente abajo de otro', () {
      final barcosJuntos = [
        Barco(tipo: TiposBarcos.bote,       inicio: const Coordenada(fila: 4, columna: 1), fin: const Coordenada(fila: 4, columna: 1)),
        Barco(tipo: TiposBarcos.lancha,     inicio: const Coordenada(fila: 1, columna: 0), fin: const Coordenada(fila: 2, columna: 0)), // Adyacente arriba
        Barco(tipo: TiposBarcos.submarino,  inicio: c40, fin: c42),
        Barco(tipo: TiposBarcos.crucero,    inicio: c60, fin: c63),
        Barco(tipo: TiposBarcos.portaviones,inicio: c80, fin: c84)
      ];
      expect(() => Flotilla(barcosJuntos), throwsA(isA<FlotillaBarcosSuperpuestosException>()));
    });
  });
}
