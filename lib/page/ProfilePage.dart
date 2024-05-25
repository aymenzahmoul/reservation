import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _getUserData(), // Récupère les données de l'utilisateur
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Une erreur s\'est produite'));
          } else {
            // Affiche les données de l'utilisateur si elles ne sont pas nulles
            if (snapshot.data != null) {
              return _buildProfile(snapshot.data!);
            } else {
              return Center(child: Text('Aucune donnée d\'utilisateur disponible'));
            }
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> _getUserData() async {
    // Dans cet exemple, nous utilisons des données fictives
    return {
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone': '+1234567890',
      'address': '123 Main Street, City',
    };
  }

  Widget _buildProfile(Map<String, dynamic> userData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/user_avatar.png'), // Ajoutez le chemin de votre image
          ),
          SizedBox(height: 20),
          Text(
            'Nom:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            userData['name'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Email:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            userData['email'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Téléphone:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            userData['phone'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Adresse:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            userData['address'],
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
