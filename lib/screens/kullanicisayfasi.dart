import 'dart:async';
import 'package:a1/models/crud.dart';
import 'package:a1/screens/girissayfasi.dart';
import 'package:a1/screens/kisiselbilgiler.dart';
import 'package:a1/screens/personelekle.dart';
import 'package:a1/screens/personellistesi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class KullaniciSayfasi extends StatefulWidget {
  @override
  _KullaniciSayfasiState createState() => _KullaniciSayfasiState();
}

class _KullaniciSayfasiState extends State<KullaniciSayfasi> {
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
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: AssetImage(
            'assets/images/bitirmelogo.png',
          ),
          height: _height * 0.40,
          width: _width * 0.40,
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new GirisSayfasi()))
              .then((value) => Navigator.pop(context)),
        ),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black54, width: 10)),
                color: Colors.white,
                child: Container(
                    alignment: Alignment.center,
                    height: _height * 0.2,
                    width: _width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/images/kisiselbilgi.png',
                          ),
                          height: _height * 0.1,
                          width: _width * 0.1,
                        ),
                        Text(
                          "Kişisel Bilgilerim",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new KisiselBilgiler()));
                },
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Container(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black54, width: 10)),
                color: Colors.white,
                child: Container(
                    height: _height * 0.2,
                    width: _width * 0.35,
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/images/personeller.png',
                          ),
                          height: _height * 0.1,
                          width: _width * 0.15,
                        ),
                        Text(
                          "Personellerim",
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
                onPressed: () {
                  String bolum = kisisel.docs[0].get("birim");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => new PersonelListesi(
                                bolum: bolum,
                              )));
                },
              ),
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black54, width: 10)),
              color: Colors.white,
              child: Container(
                  height: _height * 0.2,
                  width: _width * 0.35,
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/ekleme.png',
                        ),
                        height: _height * 0.1,
                        width: _width * 0.1,
                      ),
                      Text(
                        "Personel Ekle",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new PersonelEkle()));
              },
            ),
            SizedBox(
              height: _height * 0.02,
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: IconButton(
                  iconSize: 50,
                  color: Colors.red,
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => new GirisSayfasi()))
                        .then((value) => Navigator.pop(context));
                  },
                )),
          ],
        ),
      ),
    );
  }
}
