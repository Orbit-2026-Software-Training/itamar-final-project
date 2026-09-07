import 'dart:convert';
import 'dart:io';
void main() async {
  List<double> temperatures = [];
  String fliePath =
      r"readings.json";
      
  final file = File(fliePath);
  final jsonString = await file.readAsString();

  List<dynamic> list = jsonDecode(jsonString);

  // Loop through the list and add the temperature to the list that has the temperatures as a double 
  for (var item in list) {
    double temp = (item['temperature'] as num).toDouble();
    temperatures.add(temp);
  }
  temperatures.sort();
  print(temperatures);
}