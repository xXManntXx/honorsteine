import 'package:flutter/material.dart';
import 'package:honorsteine/API_res/stolpersteineData.dart';
import 'package:honorsteine/screens/chat_page.dart';
import 'package:honorsteine/screens/forYouPage.dart';
import 'package:honorsteine/screens/victimListPage.dart';
import 'package:honorsteine/screens/StolpersteineMap.dart';

import '../api/chat_api.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.allVictims, required this.startingPageIndex, required this.victim});

  final String title;
  final Future<List<StolpersteineData>> allVictims;
  final int startingPageIndex;
  final StolpersteineData victim;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> pages;
  late int pageIndex;
  late String pageTitle;

  void setPage(int index) {
    setState(() {
      pageIndex = index;
      switch(index){
        case 0:
          pageTitle = "Honorsteine";
          break;
        case 1:
          pageTitle = "Around you";
          break;
        case 2:
          pageTitle = "All stolpersteine";
          break;
        case 3 :
          pageTitle = "Chat bot";
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    pageTitle = widget.title;
    pageIndex = widget.startingPageIndex;

    final ChatApi chatApi = ChatApi(widget.victim);

    pages = [
      ForYouPage(allVictims: widget.allVictims),
      MapPage(allVictims: widget.allVictims),
      Victim_List(allVictims: widget.allVictims),
      ChatPage(chatApi: chatApi, allVictims: widget.allVictims, victim: widget.victim,)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
      ),
      body: Center(
        child: pages.elementAt(pageIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Stolpersteines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Chat',
          ),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        onTap: setPage,
      ),
    );
  }
}
