enum TiposBarcos{
  bote,lancha,submarino,crucero,portaviones
}

class Barco{
TiposBarcos tipo;
Barco(this.tipo);

}
class Flotilla {
  List<Barco> _barcos;
  int get cantidad => _barcos.length;
  Flotilla(List<Barco> this._barcos){
    if(_barcos.length != 5) throw FlotillaCantidadException();
    final tipos = _barcos.map((barco) => barco.tipo).toSet();
    if (tipos.length != 5) {
    _validarBarcosUnicos(_barcos);
  }

  void _validarBarcosUnicos(List<Barco> barcos) {
    final tipos = barcos.map((barco) => barco.tipo).toSet();
    if (tipos.length != barcos.length) {
      throw FlotillaBarcosRepetidosException();
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
