import 'dart:async';

import 'package:a1/widgets/rounded_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:a1/models/crud.dart';

import '../widgets/rounded_input_field2.dart';

class PersonelListesi extends StatefulWidget {
  final String bolum;

  const PersonelListesi({Key key, this.bolum}) : super(key: key);
  @override
  _PersonelListesiState createState() => _PersonelListesiState(bolum);
}

class _PersonelListesiState extends State<PersonelListesi> {
  final String bolum;
  QuerySnapshot personel;
  crudMedthods crudObj = new crudMedthods();

  _PersonelListesiState(this.bolum);

  @override
  void initState() {
    crudObj.getPersonel(bolum).then((results) {
      personel = results;
    });
    super.initState();
  }

  Future<Null> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    crudObj.getPersonel(bolum).then((results) {
      setState(() {
        personel = results;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personel Listesi",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              color: Colors.black87,
              child: Text(
                "Bilgileri görmek için kişiye tıklayın.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            Expanded(
              child: Container(

                  // alignment: Alignment.center,
                  color: Colors.black87,
                  child: _personel()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _personel() {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    if (personel != null) {
      return ListView.builder(
          itemCount: personel.docs.length,
          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
          itemBuilder: (context, i) {
            return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: _width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 5,
                    color: Colors.black54,
                  ),
                ),
                child: Column(children: <Widget>[
                  ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: Colors.redAccent[700],
                      ),
                      onPressed: () {
                        _showMyDialog2(i);
                        isim2 = personel.docs[i].get("isim");
                        soyisim2 = personel.docs[i].get("soyisim");
                        tc2 = personel.docs[i].get("tc");
                        birim2 = personel.docs[i].get("birim");
                        unvan2 = personel.docs[i].get("unvan");
                        hes2 = personel.docs[i].get("hes");
                      },
                    ),
                    title: Text(
                      (personel.docs[i].get("isim") +
                          " " +
                          personel.docs[i].get("soyisim")),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _height * 0.025,
                          color: Colors.black),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Yenilemek için aşağı çekiniz!!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        setState(() {
                          crudObj.personelSil(personel.docs[i].id);
                        });
                      },
                      icon: Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent[700],
                      ),
                    ),
                    onTap: () {
                      _showMyDialog(i);
                    },
                  ),
                ]));
          });
    } else {
      startTimer();
      return Container(
        alignment: Alignment.center,
        child: Text(
          "Yükleniyor, Lütfen Bekleyin..",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    }
  }

  int _start;
  Timer timer;
  String isim2, soyisim2, tc2, birim2, unvan2, hes2;

  Future<void> _showMyDialog2(int x) async {
    Size size = MediaQuery.of(context).size;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'PERSONEL DÜZENLE',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "İsim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("isim"),
                        onChanged: (value) {
                          isim2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "Soyisim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("soyisim"),
                        onChanged: (value) {
                          soyisim2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "Tc",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("tc"),
                        onChanged: (value) {
                          tc2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "Birim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("birim"),
                        onChanged: (value) {
                          birim2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "Ünvan",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("unvan"),
                        onChanged: (value) {
                          unvan2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: size.width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: Text(
                          "HES",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: size.width * 0.45,
                      child: RoundedInputField2(
                        veri: personel.docs[x].get("hes"),
                        onChanged: (value) {
                          hes2 = value;
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(29),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("İptal")),
            FlatButton(
              child: Text('Kaydet'),
              onPressed: () {
                if (tc2 == null || tc2.length != 11) {
                  Fluttertoast.showToast(
                      msg: "TC'yi doğru giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (hes2 == null || hes2.length != 12) {
                  Fluttertoast.showToast(
                      msg: "HES Kodunu Doğru Giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (unvan2 == null || unvan2.length < 3) {
                  Fluttertoast.showToast(
                      msg: "Unvanı Doğru Giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (birim2 == null || birim2.length < 3) {
                  Fluttertoast.showToast(
                      msg: "Birimi Doğru Giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (soyisim2 == null || soyisim2.length < 3) {
                  Fluttertoast.showToast(
                      msg: "Soyismi Doğru Giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else if (isim2 == null || isim2.length < 3) {
                  Fluttertoast.showToast(
                      msg: "İsmi Doğru Giriniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  Map<String, dynamic> personelBilgi = {
                    'isim': isim2,
                    'soyisim': soyisim2,
                    'tc': tc2,
                    'birim': birim2,
                    'unvan': unvan2,
                    'hes': hes2,
                  };
                  crudObj.personelDuzenle(personel.docs[x].id, personelBilgi);
                  Navigator.of(context).pop();
                  Fluttertoast.showToast(
                      msg: "Yenilemek için aşağı çekiniz!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Future<void> _showMyDialog(int x) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'PERSONEL BİLGİSİ',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "İsim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("isim"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "Soyisim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("soyisim"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "TC",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("tc"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "Birim",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("birim"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "Ünvanı",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("unvan"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          "HES KODU",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        color: Colors.black87,
                        child: Text(
                          personel.docs[x].get("hes"),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          backgroundColor: Colors.white,
        );
      },
    );
  }

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
