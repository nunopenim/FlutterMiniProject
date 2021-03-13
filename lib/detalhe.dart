import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
            child: widget.incidente.resolvido
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.titulo,
                        decoration: InputDecoration(
                            labelText: 'Título',
                            hintText: 'Título',
                            border: OutlineInputBorder()),
                        maxLength: 25,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.morada,
                        decoration: InputDecoration(
                            labelText: 'Morada',
                            hintText: 'Morada',
                            border: OutlineInputBorder()),
                        maxLength: 60,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.data.toString().split(".")[0],
                        decoration: InputDecoration(
                            labelText: 'Data do incidente',
                            hintText: 'Data do incidente',
                            border: const OutlineInputBorder()),
                        maxLength: 200,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.descricao,
                        decoration: InputDecoration(
                            labelText: 'Descrição',
                            hintText: 'Descrição',
                            border: const OutlineInputBorder()),
                        maxLength: 200,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.titulo,
                        decoration: InputDecoration(
                            labelText: 'Título',
                            hintText: 'Título',
                            border: OutlineInputBorder()),
                        maxLength: 25,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.data.toString().split(".")[0],
                        decoration: InputDecoration(
                            labelText: 'Data do incidente',
                            hintText: 'Data do incidente',
                            border: const OutlineInputBorder()),
                        maxLength: 200,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.morada,
                        decoration: InputDecoration(
                            labelText: 'Morada',
                            hintText: 'Morada',
                            border: OutlineInputBorder()),
                        maxLength: 60,
                        minLines: 3,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      TextFormField(
                        initialValue: widget.incidente == null
                            ? ''
                            : widget.incidente.descricao,
                        decoration: InputDecoration(
                            labelText: 'Descrição',
                            hintText: 'Descrição',
                            border: const OutlineInputBorder()),
                        maxLength: 200,
                        maxLines: 3,
                        minLines: 3,
                        textAlign: TextAlign.justify,
                        textAlignVertical: TextAlignVertical.center,
                        readOnly: true,
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        child: Text(
                          "Editar detalhes do Incidente",
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
                            gestorIncidentes.changeIncidente(value, index);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
