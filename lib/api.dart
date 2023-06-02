import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> getTempo(String city) async {
  var url = Uri.parse(
      'https://weather.contrateumdev.com.br/api/weather/city/?city=$city');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Erro na solicitação: ${response.statusCode}');
  }
}
