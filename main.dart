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

  // finds the average temperature and the number of times the temperature was bigger than 25 */
  int count_times_bigger_then_25 = 0;
  for (double temp in temperatures) {
    if (temp > 25) {
      count_times_bigger_then_25++;
    }
  }

  double average = temperatures.reduce((a, b) => a + b) / temperatures.length;
  print(average);
  print(count_times_bigger_then_25);
}
