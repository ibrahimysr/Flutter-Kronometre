import 'dart:async';

import 'package:flutter/material.dart';

class Kronometre extends StatefulWidget {
  const Kronometre({Key? key}) : super(key: key);

  @override
  State<Kronometre> createState() => _KronometreState();
}

class _KronometreState extends State<Kronometre> {
  int saniye = 0;
  int dakika = 0;
  int saat = 0;

  String Digitalsaniye = "00", Digitaldakika = "00", Digitalsaat = "00";

  Timer? timer;
  bool started = false;
  bool turalma = false;
  List Tur = [];

  void stop() {
    if (timer != null) {
      timer?.cancel();
    }
    setState(() {
      started = false;
    });
  }

  void reset() {
    if (timer != null) {
      timer?.cancel();
    }

    setState(() {
      saniye = 0;
      dakika = 0;
      saat = 0;

      Digitalsaniye = "00";
      Digitaldakika = "00";
      Digitalsaat = "00";
      started = false;
    });
  }

  void addLaps() {
    String lap = "$Digitalsaat:$Digitaldakika:$Digitalsaniye";

    setState(() {
      Tur.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int Localseconds = saniye + 1;
      int LocalMinutes = dakika;
      int LocalHours = saat;

      if (Localseconds > 59) {
        LocalMinutes++;
        Localseconds = 0;
      }
      if (LocalMinutes > 59) {
        LocalHours++;
        LocalMinutes = 0;
      }
      setState(() {
        started = true;
        saniye = Localseconds;
        dakika = LocalMinutes;
        saat = LocalHours;
        Digitalsaniye = (saniye >= 10) ? "$saniye" : "0$saniye";
        Digitaldakika = (dakika >= 10) ? "$dakika" : "0$dakika";
        Digitalsaat = (saat >= 10) ? "$saat" : "0$saat";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Kronometre",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "$Digitalsaat:$Digitaldakika:$Digitalsaniye",
                style: TextStyle(fontSize: 60),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 0.5))
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20)),
                height: 300,
                child: ListView.builder(
                  itemCount: Tur.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tur:${index + 1}",
                            style:const  TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            "${Tur[index]}",
                            style:const  TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF8a0c00),
                        ),
                        onPressed: () {
                          print(started);
                          (started) ? stop() : start();
                        },
                        child: Text((started) ? "Durdur" : "Başlat",
                            style: TextStyle(fontSize: 20))),
                  ),
                  IconButton(
                      onPressed: () {
                        addLaps();
                      },
                      icon:const  Icon(Icons.flag),
                      iconSize: 40),
                  SizedBox(
                      width: 150,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF8a0c00)),
                          onPressed: () {
                            reset();
                            Tur.clear();
                          },
                          child: const Text(
                            "Sıfırla",
                            style: TextStyle(fontSize: 20),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
