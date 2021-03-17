import 'dart:ffi';

import 'package:a1/models/crud.dart';
import 'package:a1/screens/kullanicisayfasi.dart';
import 'package:a1/widgets/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class GirisSayfasi extends StatefulWidget {
  @override
  _GirisSayfasiState createState() => _GirisSayfasiState();
}

class _GirisSayfasiState extends State<GirisSayfasi> {
  QuerySnapshot yonetici;
  crudMedthods crudObj = new crudMedthods();
  String _id;
  String _sifre;
  @override
  void initState() {
    crudObj.getData().then((results) {
      yonetici = results;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          color: Colors.black87,
          child: Column(
            children: [
              SizedBox(height: _height * 0.14),
              Image(
                image: AssetImage(
                  'assets/images/bitirmelogo.png',
                ),
                height: _height * 0.3,
                width: _width * 0.9,
              ),
              RoundedInputField(
                hintText: "Kullanıcı Adı",
                onChanged: (value) {
                  _id = value;
                },
              ),
              RoundedInputField(
                icon: Icons.vpn_key,
                hintText: "Şifre",
                gizli: true,
                onChanged: (value) {
                  _sifre = value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                child: RaisedButton(
                  onPressed: () {
                    print(yonetici.docs[0].get("birim"));
                    if (_id == yonetici.docs[0].get("id") &&
                        _sifre == yonetici.docs[0].get("sifre")) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new KullaniciSayfasi()));
                    } else {
                      Fluttertoast.showToast(
                          msg: "Giriş Bilgileri Yanlış!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white)),
                  child: Text(
                    "Giriş",
                    style: TextStyle(color: Colors.white),
                  ),
                  splashColor: Colors.white,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
