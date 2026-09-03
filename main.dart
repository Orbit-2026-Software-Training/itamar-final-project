  import 'dart:convert';
import 'dart:io';
void main() async {
  List<int> temperatures =[];

  String fliePath = r"C:\Users\User\Desktop\Itamar's Projects\json\readings.json";
  final file = File(fliePath);
  final jsonString = await file.readAsString();
  Map<String, dynamic>list = jsonDecode(jsonString);
      int temp = list['temperature'] as int;

  temperatures.add(temp);
  double average = temperatures.reduce((a, b) => a + b) / temperatures.length;
  print(average);
}