import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'editar_inscrito_screen.dart';

class InscritosScreen extends StatefulWidget {
  final String categoria;

  const InscritosScreen({super.key, required this.categoria});

  @override
  createState() => _InscritosScreenState();
}

class _InscritosScreenState extends State<InscritosScreen> {
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inscritos en ${widget.categoria}',
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 201, 203),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value.toLowerCase(); // Convertir a minúsculas
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('inscritos')
            .where('categoria', isEqualTo: widget.categoria)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No se encontraron inscritos.'));
          }

          final inscritos = snapshot.data!.docs.where((doc) {
            final nombre = (doc['nombre'] as String).toLowerCase();
            return nombre.contains(_searchTerm);
          }).toList();

          return ListView.builder(
            itemCount: inscritos.length,
            itemBuilder: (context, index) {
              final inscrito = inscritos[index];
              final nombre = inscrito['nombre'];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 27, 201, 203),
                    foregroundColor: Colors.white,
                    child: Text('${inscrito['numero']}'),
                  ),
                  title: Text(
                    nombre,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'RUT: ${inscrito['rut']} - Tel: ${inscrito['telefono']} - Edad: ${inscrito['edad']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarInscritoScreen(inscrito: inscrito),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('inscritos')
                              .doc(inscrito.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
