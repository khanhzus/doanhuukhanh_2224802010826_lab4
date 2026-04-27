import 'package:cloud_firestore/cloud_firestore.dart';

class CrudServices {
  final col = FirebaseFirestore.instance.collection('contacts');

  Future addContact(name, phone, email) async {
    await col.add({
      'name': name,
      'phone': phone,
      'email': email,
    });
  }

  Stream<QuerySnapshot> getContacts() {
    return col.snapshots();
  }

  Future updateContact(id, name, phone) async {
    await col.doc(id).update({
      'name': name,
      'phone': phone,
    });
  }

  Future deleteContact(id) async {
    await col.doc(id).delete();
  }
}