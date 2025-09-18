class LongitudMinimaException extends Error {}
class LongitudMaximaException extends Error {}
class CaracteresInvalidosException extends Error {}
class EmpiezaConNumeroException extends Error {}

const LongitudMinimaPermitida = 5;
const LongitudMaximaPermitida = 15;

class Nombre {
  late String candidato;

  Nombre(String c) {
    if (c.length < LongitudMinimaPermitida) {
      throw LongitudMinimaException();
    }

    if (c.length > LongitudMaximaPermitida) {
      throw LongitudMaximaException();
    }

    if (RegExp(r'^\d').hasMatch(c)) {
      throw EmpiezaConNumeroException();
    }

    final regExp = RegExp(r'^[a-zA-ZñÑ0-9]+$');
    if (!regExp.hasMatch(c)) {
      throw CaracteresInvalidosException();
    }

    candidato = c;
  }
}
