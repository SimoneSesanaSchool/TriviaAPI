import 'dart:convert';
import 'package:http/http.dart' as http;

/// Classe per inviare richieste alla api
class Api {
  final String url;
  Api(this.url);

  Future<Map<String, dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(url));

    /// Prima di lanciare un'exception si riprova per 5 volte a inviare la
    /// richiesta alla api
    int i = 0;
    while (response.statusCode != 200 && i < 5){
      http.Response response = await http.get(Uri.parse(url));
      i++;
    }

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Errore nel caricamento dei dati');
    }
  }
}