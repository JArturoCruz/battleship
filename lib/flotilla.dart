import 'package:battleship/coordenada.dart';
import 'dart:math';

enum TiposBarcos{
  bote,lancha,submarino,crucero,portaviones
}

extension TiposBarcosExtension on TiposBarcos {
  int get tamano {
    switch (this) {
      case TiposBarcos.bote: return 1;
      case TiposBarcos.lancha: return 2;
      case TiposBarcos.submarino: return 3;
      case TiposBarcos.crucero: return 4;
      case TiposBarcos.portaviones: return 5;
    }
  }
}

class Barco{
  final TiposBarcos tipo;
  final Coordenada inicio;
  final Coordenada fin;
  int get tamano => tipo.tamano;

  Barco({required this.tipo, required this.inicio, required this.fin}) {
    _validarPosicionYTamano();
  }

  void _validarPosicionYTamano() {
    final esHorizontal = inicio.fila == fin.fila;
    final esVertical = inicio.columna == fin.columna;

    if (!esHorizontal && !esVertical) {
      throw BarcoPosicionDiagonalException();
    }

    int distancia;
    if (esHorizontal) {
      distancia = (inicio.columna - fin.columna).abs() + 1;
    } else { // esVertical
      distancia = (inicio.fila - fin.fila).abs() + 1;
    }

    if (distancia != tamano) {
      throw BarcoTamanoIncorrectoException();
    }
  }

  Set<Coordenada> get casillasOcupadas {
    final Set<Coordenada> casillas = {};
    final filaMin = min(inicio.fila, fin.fila);
    final filaMax = max(inicio.fila, fin.fila);
    final colMin = min(inicio.columna, fin.columna);
    final colMax = max(inicio.columna, fin.columna);

    for (int f = filaMin; f <= filaMax; f++) {
      for (int c = colMin; c <= colMax; c++) {
        casillas.add(Coordenada(fila: f, columna: c));
      }
    }
    return casillas;
  }

  Set<Coordenada> get areaInfluencia {
    final Set<Coordenada> area = {};
    for (final casilla in casillasOcupadas) {
      area.addAll(casilla.adyacentes);
    }
    return area..addAll(casillasOcupadas);
  }
}

class Flotilla {
  List<Barco> _barcos;
  int get cantidad => _barcos.length;
  Flotilla(List<Barco> this._barcos){
    if (_barcos.length != 5) throw FlotillaCantidadException();
    _validarTiposUnicos(_barcos);
    _validarSeparacionEntreBarcos(_barcos);
  }

  void _validarTiposUnicos(List<Barco> barcos) {
    final tipos = barcos.map((barco) => barco.tipo).toSet();
    if (tipos.length != barcos.length) {
      throw FlotillaBarcosRepetidosException();
    }
  }

  void _validarSeparacionEntreBarcos(List<Barco> barcos) {
    final Set<Coordenada> todasLasAreas = {};
    for (final barco in barcos) {
      if (todasLasAreas.intersection(barco.casillasOcupadas).isNotEmpty) {
        throw FlotillaBarcosSuperpuestosException();
      }
      todasLasAreas.addAll(barco.areaInfluencia);
    }
  }
}

class FlotillaCantidadException implements Exception {
  @override
  String toString() => 'La flotilla debe tener exactamente 5 barcos.';
}

class FlotillaBarcosRepetidosException implements Exception {
  @override
  String toString() => 'No se permiten tipos de barcos repetidos en la flotilla.';
}

class FlotillaBarcosSuperpuestosException implements Exception {
  @override
  String toString() => 'Los barcos no pueden estar juntos ni superpuestos.';
}

class BarcoPosicionDiagonalException implements Exception {
  @override
  String toString() => 'El barco no puede estar posicionado en diagonal.';
}

class BarcoTamanoIncorrectoException implements Exception {
  @override
  String toString() => 'La distancia entre las coordenadas no coincide con el tamaño del barco.';
}
