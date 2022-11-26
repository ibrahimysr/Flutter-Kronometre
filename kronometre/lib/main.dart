

import 'package:flutter/material.dart';
import 'package:kronometre/kronometre.dart';
import 'package:kronometre/sayac.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int secilisayfa = 0;
  void sayfadegistir(int index) {
    setState(() {
      secilisayfa = index;
    });
  }

  sayfagoster(int secilisayfa) {
    if (secilisayfa == 0) {
      return const Kronometre();
    } else if (secilisayfa == 1) {
      return const Sayac();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: "Kronometre",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.av_timer_rounded), label: "Sayaç"),
            ],
            backgroundColor: Colors.black,
            selectedIconTheme:const  IconThemeData(color: Colors.grey),
            selectedItemColor: Colors.grey,
            unselectedIconTheme:const  IconThemeData(color: Colors.white),
            currentIndex: secilisayfa,
            onTap: sayfadegistir,
            type: BottomNavigationBarType.fixed),
        backgroundColor: Colors.black,
        body: sayfagoster(secilisayfa),
      ),
    );
  }
}
