import 'package:flutter/material.dart';

import 'blocs/incidente.dart';

class PaginaForm extends StatefulWidget {
  final String title;
  final Incidente incidente;

  PaginaForm({this.title, this.incidente});

  @override
  _PaginaFormState createState() => _PaginaFormState();
}

class _PaginaFormState extends State<PaginaForm> {
  String _titulo;
  String _descricao;
  String _morada;
  DateTime _data;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Formulário")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  initialValue:
                      widget.incidente == null ? '' : widget.incidente.titulo,
                  decoration: InputDecoration(
                      labelText: 'Título',
                      hintText: 'Título',
                      border: OutlineInputBorder()),
                  maxLength: 25,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'É necessário um título para o incidente';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _titulo = value;
                  },
                ),
                SizedBox(height: 25),
                TextFormField(
                  initialValue:
                      widget.incidente == null ? '' : widget.incidente.morada,
                  decoration: InputDecoration(
                      labelText: 'Morada',
                      hintText: 'Morada',
                      border: OutlineInputBorder()),
                  maxLength: 60,
                  validator: (String value) {
                    return null;
                  },
                  onSaved: (String value) {
                    _morada = value;
                  },
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'É obrigatória uma descrição';
                    }
                    if (value.length < 100) {
                      return 'São necessários pelo menos 100 caractéres';
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _descricao = value;
                  },
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  child: Text(
                    //se for null novo, caso contrário edição. assim só um formulário
                    widget.incidente == null ? 'Submeter' : 'Editar',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    if (widget.incidente == null) {
                      _data = DateTime.now();
                    } else {
                      _data = widget.incidente.data;
                    }
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    _formKey.currentState.save();
                    Navigator.of(context)
                        .pop(Incidente(_titulo, _descricao, _morada, _data));
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
