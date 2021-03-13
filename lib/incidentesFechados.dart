import 'package:flutter/material.dart';
import 'package:miniprojeto/main.dart';

import 'blocs/incidenteManager.dart';

import 'detalhe.dart';

class IncidentesFechados extends StatefulWidget {
  @override
  _IncidentesFechadosState createState() => _IncidentesFechadosState();
}

class _IncidentesFechadosState extends State<IncidentesFechados> {
  Incidentes gestorIncidentes = Incidentes.getInstance();
  IncidentesDone incidente_done_manager = IncidentesDone.getInstance();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          incidente_done_manager.dispose();
          gestorIncidentes.dispose();
          gestorIncidentes.reload();
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) =>
                      AppScreen(title: "Gestor de Incidentes")));
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text("Incidentes Fechados"),
          ),
          body: StreamBuilder(
            initialData: [],
            stream: incidente_done_manager.output,
            builder: (BuildContext context, snapshot) => ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final incidente = snapshot.data[index];
                  return ListTile(
                    title: Text(incidente.titulo +
                        "\n" +
                        incidente.data.toString().split(".")[0]),
                    trailing:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.remove_red_eye),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detalhe(incidente: incidente)));
                          }),
                    ]),
                  );
                }),
          ),
        ));
  }
}
