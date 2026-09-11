import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;

void main() async {
  File csvFile = File('log_report.csv');
  List<List<String>> dataToImportToCsv = [
    ['what was done'],
  ];

  void recordNewTask(String taskDescription) {
    dataToImportToCsv.add([taskDescription]);
  }

  // Import the api for the jokes
  final url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Any?type=single&amount=10',
  );

  final response = await http.get(url);
  final jokes = jsonDecode(response.body);

  File jokesFile = File('jokes.json');
  jokesFile.writeAsStringSync(jsonEncode(jokes));
  recordNewTask("importing the api");

  // Read the json decoded to a string and add it to a list
  String jokesAsString = await jokesFile.readAsString();
  List<String> jokesList = [];
  jokesList.add(jokesAsString);
  recordNewTask("read the json and decoded it to a string and it to a list");

  // Take only the jokes from the json and loop thru the list and check the length of the string of each joke and it to a list and sort it
  List<dynamic> jokelist = jsonDecode(jokesAsString)['jokes'];
  List<double> jokelength = [];
  for (var item in jokelist) {
    double joke = (item['joke'] as String).length.toDouble();
    jokelength.add(joke);
    jokelength.sort();
  }
  recordNewTask(
    "take only the jokes from the json and and loop thru the list and check the length of the string of each joke and it to a list and sort it ",
  );

  // Print the first, last and avgrage length of the string
  print("jokelength.first: ${jokelength.first}");
  print("jokelength.last: ${jokelength.last}");
  double jokeaverage = jokelength.reduce((a, b) => a + b) / jokelength.length;
  print("jokeaverage: $jokeaverage");
  recordNewTask("print the first last and average length of the string");
  // Read the temperatures JSON as a string
  List<double> temperatures = [];
  String filePath = r"readings.json";
  final file = File(filePath);
  final jsonString = await file.readAsString();
  List<dynamic> list = jsonDecode(jsonString);
  recordNewTask("read the temperatures JSON as a string");

  // Loop through the list and add the temperature to the list that has the temperatures as a double
  for (var item in list) {
    double temp = (item['temperature'] as num).toDouble();
    temperatures.add(temp);
  }
  recordNewTask(
    "Loop through the list and add the temperature to the list that has the temperatures as a double",
  );

  // Find the avgrage temparuture and set variables for the error precentage function for temperatures
  double Temp_average =
      temperatures.reduce((a, b) => a + b) / temperatures.length;
  double error_percentage_resault_max_temp = 0;
  double error_percentage_resault_min_temp = 0;
  recordNewTask(
    "find the avgrage temparuture and set variables for the error precentage function",
  );

  // Finding the error precentage functions for temperatures
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

  recordNewTask("finding the error precentage functions for temperatures");

  // Seting variables for the joke error precentage
  double error_percentage_resaultMinJoke = 0;
  double error_percentage_resault_max_joke = 0;
  recordNewTask("seting variables");

  // Error precentage function this time for jokes
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

  recordNewTask("error precentage function this time for jokes");

  // Calling the functions
  error_percentage_joke();
  error_percentage_temp();
  recordNewTask("calling the functions");

  // Check which value out of both functions was the highest
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
  recordNewTask("check which value out of both functions was the highest");

  // Sorting both lists
  for (int i = 0; i < temperatures.length - 1; i++) {
    for (int j = 0; j < temperatures.length - i - 1; j++) {
      if (temperatures[j] > temperatures[j + 1]) {
        double currentTempForListSorting = temperatures[j];
        temperatures[j] = temperatures[j + 1];
        temperatures[j + 1] = currentTempForListSorting;
      }
    }
  }

  jokelength.sort();
  recordNewTask("sorting both lists");

  // Printing resualts from the functions
  print("temperatures.last: ${temperatures.last}");
  print("temperatures.first: ${temperatures.first}");
  print("average.temperature: $Temp_average");
  print("the highest precentage is $highest_value");
  recordNewTask("printing resualts from the functions");

  // Convert the recorded tasks list to a CSV string and save it to the CSV file
  String csvData = const ListToCsvConverter().convert(dataToImportToCsv);
  await csvFile.writeAsString(csvData);
}