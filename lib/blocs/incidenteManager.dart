import 'dart:async';
import 'dart:math';

import 'incidente.dart';

// gestor de incidentes
class Incidentes {
  static Incidentes _incidenteManager;
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;
  List<Incidente> incidentesEmAberto = [];

  Incidentes._internal();

  bool _areAllSolved() {
    for (var i in incidentesEmAberto) {
      if (!i.estaResolvido()) {
        return false;
      }
    }
    return true;
  }

  static Incidentes getInstance() {
    if (_incidenteManager == null) {
      _incidenteManager = Incidentes._internal();
    }
    return _incidenteManager;
  }

  void addIncidente(Incidente incidente) {
    if (incidente == null || incidente.titulo.isEmpty)  {
      return;
    }
    incidentesEmAberto.add(incidente);
    _input.add(incidentesEmAberto);
  }

  void changeIncidente(Incidente incidente, int index) {
    if (incidente == null || incidente.titulo.isEmpty) {
      return ;
    }
    incidentesEmAberto[index] = incidente;
    _input.add(incidentesEmAberto);
  }

  bool solveRandom() {
    if (_areAllSolved()) {
      return false;
    }
    Random rand = new Random();
    var index = rand.nextInt(incidentesEmAberto.length);
    while (incidentesEmAberto[index].estaResolvido()) {
      index = rand.nextInt(incidentesEmAberto.length);
    }
    incidentesEmAberto[index].resolver();
    _input.add(incidentesEmAberto);
    return true;
  }

  // de acordo com a questão @31 do Piazza isto deveria funcionar
  void dispose(){
    _controller.close();
    _controller = StreamController();
  }

  void reload() {
    _input.add(incidentesEmAberto);
  }
}

class IncidentesDone {
  static IncidentesDone _incidentesDone;
  IncidentesDone._internal();
  List<Incidente> incidentes = [];
  StreamController _controller = StreamController();
  Sink get _input => _controller.sink;
  Stream get output => _controller.stream;

  static IncidentesDone getInstance() {
    if (_incidentesDone == null) {
      _incidentesDone = IncidentesDone._internal();
    }
    return _incidentesDone;
  }

  void updateListDone(Incidente incidente) {
    incidentes.add(incidente);
    _input.add(incidentes);
  }

  // de acordo com a questão @31 do Piazza isto deveria funcionar
  void dispose() {
    _controller.close();
    _controller = StreamController();
    _input.add(incidentes);
  }
}
