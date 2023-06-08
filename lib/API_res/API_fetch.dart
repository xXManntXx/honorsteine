import 'dart:convert';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:http/http.dart' as http;

Future<List<StolpersteineData>> fetchAPI() async {
  print(">>> Fetching API ...");
  final response = await http.get(Uri.parse(
      'https://api.struikelstenengids.nl/v2/export/stones?secret=yONOtKGoGO9u9O8pC247jKl9NcDxEl54C2b8N06nzgF9WR6S1I'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(">>> Answer received !");
    var data = json.decode(response.body) as List<dynamic>;
    List<StolpersteineData> allVictims = [];
    data.forEach((element) {
      allVictims.add(StolpersteineData.fromJson(element));
    });
    print(">>>First data :  ${data[0]}"
        "\n>>> Data length : ${data.length}");
    return allVictims;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(">>> Failed to retrieve data");
    throw Exception('Failed to load album');
  }
}