import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myprojects/windows/home.dart';
import 'package:myprojects/windows/info.dart';
import 'package:myprojects/windows/search.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String AppName = "Rifme";
  int _selectedIndex = 1;
  static const NewsFeed news = NewsFeed();
  static const List<Widget> _pages = <Widget>[
    news,
    SearchRifm(),
    Info(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppName),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 30,),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,size: 30,),
            label: 'Поиск',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info,size: 30,),
            label: 'Инфо',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: Colors.black87, size: 40),
        selectedItemColor: Colors.black87,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
