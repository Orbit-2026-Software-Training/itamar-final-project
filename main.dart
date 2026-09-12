import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() async {
  DateTime now = DateTime.now();
  File csvFile = File('log_report.csv');
  List<List<String>> dataToImportToCsv = [
    ['time', 'stage', 'details'],
  ];

  void recordNewTask(String time, String stage, String details) {
    dataToImportToCsv.add([time, stage, details]);
  }

  // Import the api for the jokes
  final url = Uri.parse(
    'https://v2.jokeapi.dev/joke/Any?type=single&amount=10',
  );

  final response = await http.get(url);
  final jokes = jsonDecode(response.body);

  File jokesFile = File('jokes.json');
  jokesFile.writeAsStringSync(jsonEncode(jokes));
  String time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 1', 'importing the api');

  // Read the json decoded to a string and add it to a list
  String jokesAsString = await jokesFile.readAsString();
  List<String> jokesList = [];
  jokesList.add(jokesAsString);
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 2', 'read the json and decoded it to a string and it to a list');

  // Take only the jokes from the json and loop thru the list and check the length of the string of each joke and it to a list and sort it
  List<dynamic> jokelist = jsonDecode(jokesAsString)['jokes'];
  List<double> jokelength = [];
  for (var item in jokelist) {
    double joke = (item['joke'] as String).length.toDouble();
    jokelength.add(joke);
    jokelength.sort();
  }
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(
    time24,
    'Stage 3',
    'take only the jokes from the json and and loop thru the list and check the length of the string of each joke and it to a list and sort it',
  );

  // Print the first, last and avgrage length of the string
  print("jokelength.first: ${jokelength.first}");
  print("jokelength.last: ${jokelength.last}");
  double jokeaverage = jokelength.reduce((a, b) => a + b) / jokelength.length;
  print("jokeaverage: $jokeaverage");
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 4', 'print the first last and average length of the string');

  // Read the temperatures JSON as a string
  List<double> temperatures = [];
  String filePath = r"readings.json";
  final file = File(filePath);
  final jsonString = await file.readAsString();
  List<dynamic> list = jsonDecode(jsonString);
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 5', 'read the temperatures JSON as a string');

  // Loop through the list and add the temperature to the list that has the temperatures as a double
  for (var item in list) {
    double temp = (item['temperature'] as num).toDouble();
    temperatures.add(temp);
  }
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(
    time24,
    'Stage 6',
    'Loop through the list and add the temperature to the list that has the temperatures as a double',
  );

  // Find the avgrage temparuture and set variables for the error precentage function for temperatures
  double TempAverage =
      temperatures.reduce((a, b) => a + b) / temperatures.length;
  double errorPercentageResaultMaxTemp = 0;
  double errorPercentageResaultMinTemp = 0;
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(
    time24,
    'Stage 7',
    'find the avgrage temparuture($TempAverage) and set variables for the error precentage function',
  );

  // Finding the error precentage functions for temperatures
  void error_percentage_temp() {
    errorPercentageResaultMinTemp =
        ((temperatures.first - TempAverage).abs() / TempAverage) * 100;
    errorPercentageResaultMaxTemp =
        (temperatures.last - TempAverage).abs() / TempAverage * 100;
    print(
      "the min error precentage of temps is $errorPercentageResaultMinTemp",
    );
    print(
      "the max error precentage of temps is $errorPercentageResaultMaxTemp",
    );
  }

  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 8', 'finding the error precentage functions for temperatures');

  // Seting variables for the joke error precentage
  double errorPercentageResaultMinJoke = 0;
  double errorPercentageResaultMaxJoke = 0;
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 9', 'seting variables');

  // Error precentage function this time for jokes
  void error_percentage_joke() {
    errorPercentageResaultMinJoke =
        (jokelength.first - jokeaverage).abs() / jokeaverage * 100;
    errorPercentageResaultMaxJoke =
        (jokelength.last - jokeaverage).abs() / jokeaverage * 100;
    print(
      "the max error precentage of jokes is $errorPercentageResaultMaxJoke%",
    );
    print(
      "the min error precenttage of jokes is $errorPercentageResaultMinJoke%",
    );
  }

  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 10', 'error precentage function this time for jokes');

  // Calling the functions
  error_percentage_joke();
  error_percentage_temp();
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 11', 'calling the functions');

  // Check which value out of both functions was the highest
  double highest_value = errorPercentageResaultMinJoke;
  if (errorPercentageResaultMaxTemp > highest_value) {
    highest_value = errorPercentageResaultMaxJoke;
  }
  if (errorPercentageResaultMinJoke > highest_value) {
    highest_value = errorPercentageResaultMinJoke;
  }
  if (errorPercentageResaultMaxJoke > highest_value) {
    highest_value = errorPercentageResaultMaxJoke;
  }
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 12', 'check which value out of both functions was the highest');

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
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 13', 'sorting both lists');

  // Printing resualts from the functions
  print("temperatures.last: ${temperatures.last}");
  print("temperatures.first: ${temperatures.first}");
  print("average.temperature: $TempAverage");
  print("the highest precentage is $highest_value");
  time24 = DateFormat('HH:mm').format(now);
  recordNewTask(time24, 'Stage 14', 'printing resualts from the functions');

  // Convert the recorded tasks list to a CSV string and save it to the CSV file
  String csvData = const ListToCsvConverter().convert(dataToImportToCsv);
  await csvFile.writeAsString(csvData);
}