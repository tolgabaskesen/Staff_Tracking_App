import 'package:a1/widgets/rounded_input_field.dart';
import 'package:a1/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:a1/models/crud.dart';

class PersonelEkle extends StatefulWidget {
  @override
  _PersonelEkleState createState() => _PersonelEkleState();
}

class _PersonelEkleState extends State<PersonelEkle> {
  crudMedthods crudObj = new crudMedthods();
  String isim, soyisim, tc, birim, unvan, hes;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personel Ekle",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height * 0.95,
          alignment: Alignment.topCenter,
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RoundedInputField(
                hintText: "İsim",
                text: TextInputType.name,
                onChanged: (value) {
                  isim = value;
                },
              ),
              RoundedInputField(
                hintText: "Soyisim",
                text: TextInputType.name,
                onChanged: (value) {
                  soyisim = value;
                },
              ),
              RoundedInputField(
                hintText: "TC",
                onChanged: (value) {
                  tc = value;
                },
                text: TextInputType.number,
                icon: Icons.person_outline,
              ),
              TextFieldContainer(
                child: Row(
                  children: [
                    Icon(Icons.work_outline),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    Container(
                      width: size.width * 0.5,
                      child: DropdownButton<String>(
                        hint: Text("Birimi Seçiniz"),
                        value: birim,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            birim = newValue;
                          });
                        },
                        items: <String>[
                          'Bilgi İşlem',
                          'Yazılım Mühendisliği',
                          'Hastane',
                          'Rektörlük'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              RoundedInputField(
                  hintText: "Ünvanı",
                  text: TextInputType.name,
                  onChanged: (value) {
                    unvan = value;
                  },
                  icon: Icons.person_search),
              RoundedInputField(
                hintText: "HES Kodu",
                onChanged: (value) {
                  hes = value;
                },
                text: TextInputType.name,
                icon: Icons.local_hospital,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: size.width * 0.5,
                child: RaisedButton(
                  onPressed: () {
                    if (tc == null || tc.length != 11) {
                      Fluttertoast.showToast(
                          msg: "TC'yi doğru giriniz!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (hes == null || hes.length != 12) {
                      Fluttertoast.showToast(
                          msg: "HES Kodunu Doğru Giriniz!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (unvan == null || unvan.length < 3) {
                      Fluttertoast.showToast(
                          msg: "Unvanı Doğru Giriniz!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (birim == null || birim.length < 3) {
                      Fluttertoast.showToast(
                          msg: "Birimi Doğru Giriniz!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (soyisim == null || soyisim.length < 3) {
                      Fluttertoast.showToast(
                          msg: "Soyismi Doğru Giriniz!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (isim == null || isim.length < 3) {
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
                        'isim': isim,
                        'soyisim': soyisim,
                        'tc': tc,
                        'birim': birim,
                        'unvan': unvan,
                        'hes': hes,
                      };
                      crudObj.personelEkle(personelBilgi);
                      Fluttertoast.showToast(
                          msg: "Başarıyla Eklendi!!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person_add),
                      Text(
                        "   Personeli Ekle",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
