import 'dart:convert';
import 'package:http/http.dart' as http;

/// Classe per inviare richieste alla api
class Api {
  final String url;
  Api(this.url);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Errore nel caricamento dei dati');
    }
  }
}