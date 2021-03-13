class Incidente {
  String titulo;
  String descricao;
  String morada;
  DateTime data;
  bool resolvido;

  Incidente(String titulo, String descricao, String morada, DateTime data) {
    this.titulo = titulo;
    this.descricao = descricao;
    this.morada = morada;
    this.data = data;
    this.resolvido = false;
  }

  void resolver() {
    this.resolvido = true;
  }

  bool estaResolvido() {
    return this.resolvido;
  }

  void definirMorada(String morada) {
    this.morada = morada;
  }

  DateTime getData() {
    return data;
  }
}
