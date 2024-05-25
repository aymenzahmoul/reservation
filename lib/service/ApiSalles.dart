import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = 'http://10.0.2.2:8000/api/salles';

  Future<List<dynamic>> fetchSalles() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Data received: $jsonData'); // Affichez les données reçues dans la console
        return jsonData;
      } else {
        print('Failed to load salles: ${response.statusCode}'); // Affichez le code d'erreur dans la console
        throw Exception('Failed to load salles');
      }
    } catch (e) {
      print('Error fetching salles: $e'); // Affichez l'erreur dans la console
      throw Exception('Error fetching salles');
    }
  }

}
