
enum Estado{
  creada, iniciada, terminado
}

class Partida{
late Estado estado;
Partida(){
  estado= Estado.creada;
}
}