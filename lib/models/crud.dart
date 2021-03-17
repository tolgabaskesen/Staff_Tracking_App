import 'package:cloud_firestore/cloud_firestore.dart';

class crudMedthods {
  getData() async {
    return await FirebaseFirestore.instance.collection('yonetici').get();
  }

  getPersonel(String bolum) async {
    return await FirebaseFirestore.instance
        .collection('personel')
        .where("birim", isEqualTo: bolum).get();
  }
    Future<void> personelEkle(personel) async {
    FirebaseFirestore.instance
        .collection('/personel')
        .add(personel)
        .catchError((e) {
      print(e);
    });
  }
    personelDuzenle(selectedDoc, newValues) {
    FirebaseFirestore.instance
        .collection('/personel')
        .doc(selectedDoc)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }

  personelSil(selectedDoc){
    FirebaseFirestore.instance
        .collection('/personel')
        .doc(selectedDoc)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
