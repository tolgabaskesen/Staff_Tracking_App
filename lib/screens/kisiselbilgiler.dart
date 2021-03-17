import 'dart:async';

import 'package:a1/models/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class KisiselBilgiler extends StatefulWidget {
  @override
  _KisiselBilgilerState createState() => _KisiselBilgilerState();
}

class _KisiselBilgilerState extends State<KisiselBilgiler> {
  QuerySnapshot kisisel;
  crudMedthods crudObj = new crudMedthods();

  @override
  void initState() {
    crudObj.getData().then((results) {
      kisisel = results;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kişisel Bilgilerim",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.black87,
        child: _kisisel(),
      ),
    );
  }

  Widget _kisisel() {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    if (kisisel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "İsim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("isim"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "Soyisim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("soyisim"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "TC",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("tc"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "Birim",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("birim"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "Ünvanı",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("unvan"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    "HES KODU",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
              SizedBox(
                width: 20,
              ),
              Container(
                  alignment: Alignment.center,
                  height: _height * 0.08,
                  width: _width * 0.43,
                  color: Colors.white,
                  child: Text(
                    kisisel.docs[0].get("hes"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26),
                  )),
            ],
          )
        ],
      );
    } else {
      startTimer();
      return Text(
        "Yükleniyor, Lütfen Bekleyin..",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      );
    }
  }

  int _start;
  Timer timer;
  void startTimer() {
    //GEREKSİZSE SİLL
    const oneSec = const Duration(seconds: 1);
    _start = 2;
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(() {
        if (_start < 1) {
          timer.cancel();
          setState(() {});
        } else {
          _start = _start - 1;
        }
      }),
    );
  }
}
