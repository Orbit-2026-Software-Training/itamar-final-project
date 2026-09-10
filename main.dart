import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

void main() async {
  //step 1 set the utl
  final url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Any?type=single&amount=10',
  );

  //step 2 get the jokes from the url
  final response = await http.get(url);

  //step 3 decode the JSON response
  final jokes = jsonDecode(response.body);

  //step 4 save the jokes to a file
  File jokesFile = File('jokes.json');

  //step 5 write the jokes to the file
  jokesFile.writeAsStringSync(jsonEncode(jokes));

  String jokesAsString = await jokesFile.readAsString();
  List<String> jokesList = [];
  jokesList.add(jokesAsString);
  final jsonJokeString = await jokesFile.readAsString();

  List<dynamic> jokelist = jsonDecode(jsonJokeString)['jokes'];
  List<double> jokelength = [];
  for (var item in jokelist) {
    double joke = (item['joke'] as String).length.toDouble();
    jokelength.add(joke);
    jokelength.sort();
  }
  print("jokelength.first: ${jokelength.first}");
  print("jokelength.last: ${jokelength.last}");

  double jokeaverage = jokelength.reduce((a, b) => a + b) / jokelength.length;
  print("jokeaverage: $jokeaverage");

  List<double> temperatures = [];
  String filePath = r"readings.json";
  final file = File(filePath);
  final jsonString = await file.readAsString();

  List<dynamic> list = jsonDecode(jsonString);

  // Loop through the list and add the temperature to the list that has the temperatures as a double
  for (var item in list) {
    double temp = (item['temperature'] as num).toDouble();
    temperatures.add(temp);
  }
  double Temp_average =
      temperatures.reduce((a, b) => a + b) / temperatures.length;
  double error_percentage_resault_max_temp = 0;
  double error_percentage_resault_min_temp = 0;

  void error_percentage_temp() {
    error_percentage_resault_min_temp =
        ((temperatures.first - Temp_average).abs() / Temp_average) * 100;
    error_percentage_resault_max_temp =
        (temperatures.last - Temp_average).abs() / Temp_average * 100;
    print(
      "the min error precentage of temps is $error_percentage_resault_min_temp",
    );
    print(
      "the max error precentage of temps is $error_percentage_resault_max_temp",
    );
  }

  double error_percentage_resaultMinJoke = 0;
  double error_percentage_resault_max_joke = 0;

  void error_percentage_joke() {
    error_percentage_resaultMinJoke =
        (jokelength.first - jokeaverage).abs() / jokeaverage * 100;
    error_percentage_resault_max_joke =
        (jokelength.last - jokeaverage).abs() / jokeaverage * 100;
    print(
      "the max error precentage of jokes is $error_percentage_resault_max_joke%",
    );
    print(
      "the min error precenttage of jokes is $error_percentage_resaultMinJoke%",
    );
  }

  error_percentage_joke();
  error_percentage_temp();
  
  double highest_value = error_percentage_resaultMinJoke;
  if (error_percentage_resault_max_temp > highest_value) {
    highest_value = error_percentage_resault_max_joke;
  }
  if (error_percentage_resaultMinJoke > highest_value) {
    highest_value = error_percentage_resaultMinJoke;
  }
  if (error_percentage_resault_max_joke > highest_value) {
    highest_value = error_percentage_resault_max_joke;
  }
  temperatures.sort();
  jokelength.sort();

  //print("temperatures: $temperatures");
  print("temperatures.last: ${temperatures.last}");
  print("temperatures.first: ${temperatures.first}");
  print("average.temperature: $Temp_average");
  print("the highest precentage is $highest_value");
}
