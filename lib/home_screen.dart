import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _nombre, _rut, _team, _telefono, _categoria;
  int? _numero, _edad;
  User? _user;

  final List<String> _categorias = [
    'Kids',
    'Infantil',
    'Junior',
    'Damas',
    'Novicios',
    'Rigido',
    'Experto',
    'Elite',
    'Master A',
    'Open Master'
  ];

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 201, 203),
        title: const Text('Carrera de Tucuca',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_user?.displayName ?? 'Sin nombre'),
              accountEmail: Text(_user?.email ?? 'Sin email'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _user?.displayName?.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 27, 201, 203),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Ver categorías'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Ayuda'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                _handleSignOut();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Registro de Inscripción',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el nombre';
                    }
                    return null;
                  },
                  onSaved: (value) => _nombre = value,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'RUT',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el RUT';
                    }
                    return null;
                  },
                  onSaved: (value) => _rut = value,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Team',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSaved: (value) => _team = value,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el teléfono';
                    }
                    return null;
                  },
                  onSaved: (value) => _telefono = value,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la edad';
                    }
                    final int? age = int.tryParse(value);
                    if (age == null || age <= 0) {
                      return 'Por favor ingresa una edad válida';
                    }
                    return null;
                  },
                  onSaved: (value) => _edad = int.tryParse(value ?? '0'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: _categorias.map((String category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() => _categoria = newValue);
                  },
                  value: _categoria,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: const Icon(Icons.pedal_bike,
                        size: 24, color: Colors.white),
                    label: const Text('Registrar corredor',
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
      ),
    );
  }

  void _handleSignOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          // Referencia al documento del contador
          DocumentReference counterRef = FirebaseFirestore.instance
              .collection('counters')
              .doc('inscritos_counter');

          // Leer el valor actual del contador dentro de la transacción
          DocumentSnapshot counterSnapshot = await transaction.get(counterRef);

          // Si no existe el contador, lo inicializamos en 1
          if (!counterSnapshot.exists) {
            transaction.set(counterRef, {'numero': 1});
            _numero = 1;
          } else {
            // Si existe, obtenemos el valor actual y lo incrementamos
            int currentNumber = counterSnapshot['numero'];
            _numero = currentNumber + 1;

            // Aumentar el contador en la base de datos
            transaction.update(counterRef, {'numero': _numero});
          }

          // Ahora guardamos el nuevo inscrito usando el número generado
          transaction
              .set(FirebaseFirestore.instance.collection('inscritos').doc(), {
            'nombre': _nombre,
            'rut': _rut,
            'team': _team,
            'telefono': _telefono,
            'categoria': _categoria,
            'numero': _numero,
            'edad': _edad,
            'entregado': false,
            'fecha': DateTime.now(),
          });
        });

        // Si todo sale bien, reseteamos el formulario
        _formKey.currentState!.reset();
        setState(() => _categoria = null);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Inscrito exitosamente')),
        );
      } catch (e) {
        print('Error al conectar con Firestore: $e');
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('No se pudo registrar. Revisa tu conexión a Internet.')),
        );
      }
    }
  }
}
