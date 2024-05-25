import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServices {
  // Fetch materiels method
  Future<List<dynamic>> fetchMateriels() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/materiels'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load materiels');
    }
  }

  // Function to reserve a materiel
  Future<void> reserveMateriel(int materielId, int userId) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/reservations'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'materiel_id': materielId,
        'user_id': userId,

        'start_time': DateTime.now().toIso8601String(),
        'end_time': DateTime.now().add(Duration(hours: 1)).toIso8601String(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to reserve materiel');
    }
  }
}
