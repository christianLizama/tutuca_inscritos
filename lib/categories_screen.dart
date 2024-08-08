import 'package:flutter/material.dart';
import 'inscritos_screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _categorias = [
    {'name': 'Kids', 'icon': Icons.child_care},
    {'name': 'Infantil', 'icon': Icons.child_friendly},
    {'name': 'Junior', 'icon': Icons.group},
    {'name': 'Damas', 'icon': Icons.woman},
    {'name': 'Novicios', 'icon': Icons.star_border},
    {'name': 'Rigido', 'icon': Icons.pedal_bike},
    {'name': 'Experto', 'icon': Icons.explore},
    {'name': 'Elite', 'icon': Icons.star},
    {'name': 'Master A', 'icon': Icons.star_rate},
    {'name': 'Open Master', 'icon': Icons.public},
  ];

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 27, 201, 203),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: _categorias.length,
        itemBuilder: (context, index) {
          final categoria = _categorias[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 4,
            child: ListTile(
              leading: Icon(categoria['icon'], color: const Color.fromARGB(255, 27, 201, 203)),
              title: Text(
                categoria['name'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InscritosScreen(categoria: categoria['name']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
