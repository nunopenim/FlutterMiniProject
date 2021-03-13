import 'package:flutter/material.dart';
import 'blocs/incidente.dart';
import 'formulario.dart';
import 'blocs/incidenteManager.dart';

class Detalhe extends StatefulWidget {
  Detalhe({this.incidente});

  final Incidente incidente;

  @override
  _DetalheState createState() => _DetalheState();
}

class _DetalheState extends State<Detalhe> {
  String _titulo;
  String _descricao;
  String _morada;
  DateTime _data;

  Incidentes gestorIncidentes = Incidentes.getInstance();
  IncidentesDone incidentesDone = IncidentesDone.getInstance();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incidente \"${widget.incidente.titulo}\"")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: widget.incidente.resolvido ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.titulo,
                  decoration: InputDecoration(labelText: 'Título', hintText: 'Título', border: OutlineInputBorder()),
                  maxLength: 25,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.descricao,
                  decoration: InputDecoration(labelText: 'Descrição',
                      hintText: 'Descrição',
                      border: const OutlineInputBorder()),
                  maxLength: 200,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.morada,
                  decoration: InputDecoration(
                      labelText: 'Morada', hintText: 'Morada', border: OutlineInputBorder()),
                  maxLength: 60,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
              ],
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.titulo,
                  decoration: InputDecoration(labelText: 'Título', hintText: 'Título', border: OutlineInputBorder()),
                  maxLength: 25,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.descricao,
                  decoration: InputDecoration(labelText: 'Descrição',
                      hintText: 'Descrição',
                      border: const OutlineInputBorder()),
                  maxLength: 200,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
                TextFormField(
                  initialValue:
                  widget.incidente == null ? '' : widget.incidente.morada,
                  decoration: InputDecoration(
                      labelText: 'Morada', hintText: 'Morada', border: OutlineInputBorder()),
                  maxLength: 60,
                  maxLines: 3,
                  readOnly: true,
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  child: Text(
                    "Editar detalhe",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    var index = 0;
                    for (var i in gestorIncidentes.incidentesEmAberto) {
                      if (i == widget.incidente) {
                        break;
                      }
                      index++;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PaginaForm(
                                incidente: widget.incidente)))
                        .then((value) {
                      gestorIncidentes.changeIncidente(
                          value, index);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  "O seu incidente foi editado com sucesso.")));
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}