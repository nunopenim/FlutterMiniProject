import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:miniprojeto/blocs/incidente.dart';
import 'package:miniprojeto/detalhe.dart';

import 'blocs/incidenteManager.dart';
import 'incidentesFechados.dart';
import 'formulario.dart';

bool demomakerhasran = false;

void main() => runApp(AppIncidentes());

class AppIncidentes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AppScreen(title: 'Gestor de Incidentes'));
  }
}

class AppScreen extends StatefulWidget {
  final String title;

  AppScreen({this.title});

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  Incidentes gestorIncidentes = Incidentes.getInstance();
  IncidentesDone incidentesDone = IncidentesDone.getInstance();

  void demoMaker() {
    Incidente i1 = Incidente(
        "Buraco",
        "Buraco na estrada no cruzamento da Rua das Flores com a Rua das Frutas. Cruzamento muito movimentado!",
        "",
        DateTime.now());
    gestorIncidentes.addIncidente(i1);
    Incidente i2 = Incidente(
        "Esgoto",
        "Esgoto entupido na casa do Sr. José, causa possivel é má construção do edificio. Cano possivelmente furado",
        "Rua das Flores, nº25",
        DateTime.now());
    gestorIncidentes.addIncidente(i2);
    demomakerhasran = true;
  }

  @override
  Widget build(BuildContext context) {
    if (!demomakerhasran) {
      demoMaker();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(
        //hopefully um menu hamburger, se bem me lembro de IHM
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 90.0,
              child: DrawerHeader(
                child: Text('AppIncidentes da iQueChumbei'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
            ),
            Container(
              child: ListTile(
                title: Text('Incidentes fechados'),
                leading: Icon(Icons.format_list_bulleted),
                onTap: () {
                  incidentesDone.dispose();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => IncidentesFechados()));
                },
              ),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
            Container(
              child: ListTile(
                title: Text('Adicionar Incidente'),
                leading: Icon(Icons.add),
                onTap: () {
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PaginaForm()))
                      .then((value) {
                    gestorIncidentes.addIncidente(value);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "O seu incidente foi submetido com sucesso.")));
                  });
                },
              ),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
            Container(
              child: ListTile(
                title: Text('[DEBUG] Resolver Incidente'),
                leading: Icon(Icons.bug_report_outlined),
                onTap: () {
                  Navigator.pop(context);
                  // ignore: deprecated_member_use
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(gestorIncidentes.solveRandom()
                          ? "Um dos seus incidentes foi dado como resolvido."
                          : "Não existe incidente possivel de resolver")));
                },
              ),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
            Container(
              child: ListTile(
                title: Text('[DEBUG] Run the Demo Maker'),
                leading: Icon(Icons.bug_report_outlined),
                onTap: () {
                  demoMaker();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("O construtor de exemplos executou!")));
                },
              ),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        initialData: [],
        stream: gestorIncidentes.output,
        builder: (BuildContext context, snapshot) => ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final incidente = snapshot.data[index];
              return Dismissible(
                key: Key(incidente.titulo),
                confirmDismiss: (direction) async {
                  if (incidente.estaResolvido()) {
                    incidentesDone.updateListDone(incidente);
                    setState(() {
                      snapshot.data.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("O seu incidente foi dado como fechado.")));
                    return true;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.")));
                  return false;
                },
                child: Container(
                    child: Center(
                      child: ListTile(
                        title: Text(
                            incidente.titulo +
                                "\n" +
                                incidente.data.toString().split(".")[0],
                            textScaleFactor: 1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Detalhe(incidente: incidente)));
                        },
                        trailing: incidente.estaResolvido()
                            ? null
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                    IconButton(
                                        icon: Icon(
                                          Icons.restore_from_trash_outlined,
                                          size: 35.0,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            snapshot.data.removeAt(index);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "O incidente foi eliminado com sucesso.")));
                                          });
                                        }),
                                  ]),
                        leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              incidente.estaResolvido()
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 35.0,
                                      ),
                                      onPressed: () {
                                        incidentesDone
                                            .updateListDone(incidente);
                                        setState(() {
                                          snapshot.data.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "O seu incidente foi dado como fechado.")));
                                        return true;
                                      })
                                  : IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.red,
                                        size: 35.0,
                                      ),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Este incidente ainda não se encontra resolvido, por isso não pode transitar para a lista dos fechados.")));
                                        return false;
                                      })
                            ]),
                      ),
                    ),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    height: 60.0),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PaginaForm()))
              .then((value) {
            gestorIncidentes.addIncidente(value);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("O seu incidente foi submetido com sucesso.")));
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
