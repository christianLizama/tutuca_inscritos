import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditarInscritoScreen extends StatefulWidget {
  final DocumentSnapshot inscrito;

  const EditarInscritoScreen({super.key, required this.inscrito});

  @override
  createState() => _EditarInscritoScreenState();
}

class _EditarInscritoScreenState extends State<EditarInscritoScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _nombre, _rut, _team, _telefono;

  @override
  void initState() {
    super.initState();
    _nombre = widget.inscrito['nombre'];
    _rut = widget.inscrito['rut'];
    _team = widget.inscrito['team'];
    _telefono = widget.inscrito['telefono'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Inscrito',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 27, 201, 203),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                
                initialValue: _nombre,
                decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre';
                  }
                  return null;
                },
                onSaved: (value) => _nombre = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _rut,
                decoration: const InputDecoration(labelText: 'RUT', border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el RUT';
                  }
                  return null;
                },
                onSaved: (value) => _rut = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _team,
                decoration: const InputDecoration(labelText: 'Team',border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),),
                onSaved: (value) => _team = value!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _telefono,
                decoration: const InputDecoration(labelText: 'Teléfono',border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el teléfono';
                  }
                  return null;
                },
                onSaved: (value) => _telefono = value!,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _submitForm,
                  icon: const Icon(Icons.pedal_bike,
                      size: 24, color: Colors.white),
                  label: const Text('Guardar cambios',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 27, 201, 203),
                    minimumSize: const Size(200, 50),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Actualizar el inscrito en Firestore
      FirebaseFirestore.instance
          .collection('inscritos')
          .doc(widget.inscrito.id)
          .update({
        'nombre': _nombre,
        'rut': _rut,
        'team': _team,
        'telefono': _telefono,
      });

      Navigator.pop(context);
    }
  }
}
