import 'package:flutter/material.dart';
import 'package:flutter_auth_app/service/ApiMateriels.dart';


class CategoryPages extends StatefulWidget {
  final String category;

  CategoryPages({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPages> {
  late Future<List<dynamic>> futureMateriels; // Update the variable name

  @override
  void initState() {
    super.initState();
    futureMateriels = ApiServices().fetchMateriels(); // Update the API call
  }

  Future<void> _reserveMateriel(int materielId) async {
    try {
      // Replace `1` with the actual user ID from your app's context or state
      await ApiServices().reserveMateriel(materielId, 1);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Réservation réussie')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Échec de la réservation')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégorie: ${widget.category}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<dynamic>>(
          future: futureMateriels, // Use the futureMateriels variable
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Aucune donnée disponible'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final materiel = snapshot.data![index]; // Use 'materiel' instead of 'salle'
                  // Adjust your UI to display equipment information
                  return Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                materiel['type'], // Display equipment type
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'État: ${materiel['etat']}', // Display equipment condition
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Quantité: ${materiel['quantite']}', // Display equipment quantity
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: () {
                                  _reserveMateriel(materiel['id']); // Reserve the materiel
                                },
                                child: Text('Réserver'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
