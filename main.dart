import 'dart:convert';
import 'dart:io';
void main() async {
  List<double> temperatures = [];
  String fliePath = r"C:\Users\itama\OneDrive\מסמכים\Final Project\json\readings.json";
  final file = File(fliePath);
  final jsonString = await file.readAsString();
    
     List<dynamic> list = jsonDecode(jsonString);

      for(var item in list) {
        double temp  = (item['temperature'] as num).toDouble();
        temperatures.add(temp);
      }

  double average = temperatures.reduce((a, b) => a + b) / temperatures.length;
  print(average);
}