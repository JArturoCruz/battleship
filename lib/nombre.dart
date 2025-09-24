class ErrorLongitudMinima implements Exception {
  @override
  String toString() => 'El texto es demasiado corto.';
}

class ErrorLongitudMaxima implements Exception {
  @override
  String toString() => 'El texto supera la longitud máxima permitida.';
}

class ErrorCaracterInvalido implements Exception {
  @override
  String toString() => 'Se encontraron caracteres no válidos.';
}

class Nombre {
  late final String valor;

  Nombre(String input) {
    if (!_tieneLongitudValida(input)) {
      if (input.length < minCaracteres) {
        throw ErrorLongitudMinima();
      }}

    if (!_tieneLongitudValida(input)) {
       if (input.length > maxCaracteres) {
        throw ErrorLongitudMaxima();
      }}
  
    if (!_todosCaracteresValidos(input)) {
      throw ErrorCaracterInvalido();
    }
    if (!_iniciaConLetra(input)) {
      throw ErrorCaracterInvalido();
    }
    valor = input;    
  }

  bool _tieneLongitudValida(String txt) =>
      txt.length >= minCaracteres && txt.length <= maxCaracteres;

  bool _todosCaracteresValidos(String texto) {
   return texto.split('').every((char) => caracteresValidos.contains(char));
  }

  bool _iniciaConLetra(String texto) {
    final primer = texto[0];
    return !digitos.contains(primer);
  }

  // Constantes
  static const  caracteresValidos ='ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz0123456789';
  static const  digitos ={'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
  static const  minCaracteres = 5;
  static const  maxCaracteres = 30;
}
