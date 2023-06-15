import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/screens/stolpersteineDetailsPage.dart';
import 'dart:async';

class Victim_List extends StatefulWidget {
  final Future<List<StolpersteineData>> allVictims;
  final Set<Marker> markers;

  const Victim_List({Key? key, required this.allVictims, required this.markers})
      : super(key: key);

  @override
  State<Victim_List> createState() => _Victim_ListState();
}

class _Victim_ListState extends State<Victim_List> {
  String? searchText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onSubmitted: (value) {
              setState(() {
                searchText = value;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Filter stolpersteine (city, name, ...)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          FutureBuilder<List<StolpersteineData>>(
            future: widget.allVictims,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print('>>> Snasphot has data !');
                final List<StolpersteineData> filteredData =
                    searchText != null && searchText!.isNotEmpty
                        ? snapshot.data!
                            .where((victim) =>
                                victim.name
                                    .toLowerCase()
                                    .contains(searchText!.toLowerCase()) ||
                                victim.city
                                    .toLowerCase()
                                    .contains(searchText!.toLowerCase()) ||
                                victim.reasonOfPersecussion
                                    .toLowerCase()
                                    .contains(searchText!.toLowerCase()) ||
                                victim.deathPlace
                                    .toLowerCase()
                                    .contains(searchText!.toLowerCase()))
                            .toList()
                        : snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: filteredData[index].photoLink.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                      filteredData[index].photoLink,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                )
                                : const SizedBox(),
                            title: Text(filteredData[index].name),
                            subtitle: Text(
                                "Adress : ${filteredData[index].city}, ${filteredData[index].address} "),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StolpersteineDetailsPage(
                                    stolpersteineData: filteredData[index],
                                    allVictims: widget.allVictims,
                                    markers: widget.markers,
                                  ),
                                ),
                              );
                            },
                          ),
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
    );
  }
}
