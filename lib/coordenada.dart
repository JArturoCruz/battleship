import 'package:equatable/equatable.dart';

class Coordenada extends Equatable {
  final int fila;
  final int columna;

  const Coordenada({required this.fila, required this.columna});

  @override
  List<Object?> get props => [fila, columna];

  Set<Coordenada> get adyacentes {
    final Set<Coordenada> resultado = {};
    for (var f = fila - 1; f <= fila + 1; f++) {
      for (var c = columna - 1; c <= columna + 1; c++) {
        if (f != fila || c != columna) {
          resultado.add(Coordenada(fila: f, columna: c));
        }
      }
    }
    return resultado;
  }
}
