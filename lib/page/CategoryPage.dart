import 'package:flutter/material.dart';
import 'package:flutter_auth_app/service/ApiSalles.dart';


class CategoryPage extends StatefulWidget {
  final String category;

  CategoryPage({required this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<dynamic>> futureSalles;

  @override
  void initState() {
    super.initState();
    futureSalles = ApiService().fetchSalles();

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
          future: futureSalles,
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
                  final salle = snapshot.data![index];
                  int availabilityCode = salle['disponible'] is int ? salle['disponible'] : 0; // Assuming 0 for not available, 1 for available
                  bool isAvailable = availabilityCode == 1 ? true : false;

                  return Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(salle['image']), // Utilisez votre URL d'image
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                salle['name'],
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Capacité: ${salle['capacite']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isAvailable ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isAvailable ? 'Disponible' : 'Non disponible',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                              SizedBox(height: 4),
                              ElevatedButton(
                                onPressed: isAvailable
                                    ? () {
                                  // Action de réservation si disponible
                                }
                                    : null, // Désactive le bouton si non disponible
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
