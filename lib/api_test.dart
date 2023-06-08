import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class StolpersteineData {
  final int id;
  final String name;
  final String reasonOfPassing;
  final String address;

  const StolpersteineData({
    required this.id,
    required this.name,
    required this.reasonOfPassing,
    required this.address,
  });

  factory StolpersteineData.fromJson(Map<String, dynamic> json) {
    return StolpersteineData(
      id: json['id'],
      name: json['name'].toString(),
      reasonOfPassing: json['reasonOfPassing'].toString(),
      address: json['address'].toString(),
    );
  }
}

Future<List<dynamic>> fetchAPI() async {
  print(">>> Fetching API ...");
  final response = await http.get(Uri.parse(
      'https://api.struikelstenengids.nl/v2/export/stones?secret=yONOtKGoGO9u9O8pC247jKl9NcDxEl54C2b8N06nzgF9WR6S1I'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(">>> Answer received !");
    var data = json.decode(response.body) as List<dynamic>;
    print(">>>First data :  ${data[0]}"
        "\n>>> Data length : ${data.length}");
    return data;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(">>> Failed to retrieve data");
    throw Exception('Failed to load album');
  }
}

class Api_Test extends StatefulWidget {
  const Api_Test({Key? key}) : super(key: key);

  @override
  State<Api_Test> createState() => _Api_TestState();
}

class _Api_TestState extends State<Api_Test> {
  late Future<List<dynamic>> stolpersteineData;

  @override
  void initState() {
    super.initState();
    stolpersteineData = fetchAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<List<dynamic>>(
              future: stolpersteineData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('>>> Snasphot has data !');
                  List<StolpersteineData> allVictims = [];
                  snapshot.data?.forEach((element) {
                    allVictims.add(StolpersteineData.fromJson(element));
                  });
                  //var selectedVictim = StolpersteineData.fromJson(snapshot.data![0]);
                  //return Text('Victim name : ${selectedVictim.name}');
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(allVictims[index].name.toString()),
                            subtitle: Text(
                                "Adress : ${allVictims[index].address.toString()} "),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  print('>>> Error : ${snapshot.error}');
                  return Text('error : ${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
