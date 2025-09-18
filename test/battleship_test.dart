import 'package:battleship/battleship.dart';
import 'package:battleship/jugador.dart';
import 'package:battleship/partida.dart';
import 'package:test/test.dart';

void main() {
  test('Al crearse la partida debe marcarse creada', () {
    Partida partida = new Partida();
    expect(partida.estado, equals(Estado.creada));
  });
}
