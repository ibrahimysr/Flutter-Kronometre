import 'dart:async';
import 'package:flutter/material.dart';

class Sayac extends StatefulWidget {
  const Sayac({Key? key}) : super(key: key);

  @override
  State<Sayac> createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int sayac = 60;
  Timer? timer;
  bool _stared = false;

  void stop() {
    if (timer != null) {
      timer?.cancel();
    }
    setState(() {
      _stared = false;
    });
  }

  void reset() {
    if (timer != null) {
      timer?.cancel();
    }
    setState(() {
      _stared = false;
      sayac = 60;
    });
  }

  void start() {
    _stared = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSayac = sayac - 1;
      if (localSayac == 0) {
        stop();
      } else if (sayac < 0) {
        sayac = 0;
      }

      setState(() {
        sayac = localSayac;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$sayac", style: TextStyle(fontSize: 50)),
           const  SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                (_stared) ? stop() : start();
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF8a0c00), shape: BoxShape.circle),
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: _stared
                        ? const Icon(
                            Icons.watch_later_outlined,
                            size: 40,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    reset();
                  });
                },
                icon:const  Icon(
                  Icons.flag,
                  size: 20,
                ),
                iconSize: 30),
          ],
        ),
      ),
    ));
  }
}
