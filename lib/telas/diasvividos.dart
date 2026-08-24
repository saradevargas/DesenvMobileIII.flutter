import 'package:flutter/material.dart';

class DiasVividosPage extends StatefulWidget {
  const DiasVividosPage({super.key});

  @override
  State<DiasVividosPage> createState() => _DiasVividosPageState();
}

class _DiasVividosPageState extends State<DiasVividosPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  final List entries = [];
  final List colorCodes = [600, 500];

  String _nomeResultado = '';
  int _diasResultado = 0;

  void _calcular() {
    if (_formKey.currentState!.validate()) {
      final String nome = _nomeController.text;
      final int idade = int.parse(_idadeController.text);
      final int diasVividos = idade * 365;

      setState(() {
        _nomeResultado = nome;
        _diasResultado = diasVividos;

        entries.add('$nome tem $idade anos e viveu ~ $diasVividos dias.');
      });

      _nomeController.clear();
      _idadeController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dias vividos')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 10),

              TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a idade.';
                  }

                  if (int.tryParse(value) == null) {
                    return 'Informe um número válido.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: _calcular,
                child: const Text('Calcular'),
              ),

              const SizedBox(height: 20),

              if (_nomeResultado.isNotEmpty)
                Column(
                  children: [
                    Text(
                      '$_nomeResultado, viveu aproximadamente',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),

                    Text(
                      '$_diasResultado dias',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),

              SizedBox(
                height: 200,
                width: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.amber[colorCodes[index % 2 > 0 ? 0 : 1]],
                      child: Center(child: Text('${entries[index]}')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
