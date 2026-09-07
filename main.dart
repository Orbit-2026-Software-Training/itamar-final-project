import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
void main() async {
  //step 1 set the utl
  final url = Uri.parse('https://v2.jokeapi.dev/joke/Any?format=json&amount=10');
  //step 2 get the jokes from the url
  final response = await http.get(url);
  //step 3 decode the JSON response
  final jokes = jsonDecode(response.body);
  //step 4 save the jokes to a file
  File jokesFile = File('jokes.json'); 
  //step 5 write the jokes to the file 
  jokesFile.writeAsStringSync(jsonEncode(jokes));
}