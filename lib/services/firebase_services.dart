import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rently/models/property.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addProperty(Property property) async {
    await _firestore.collection('properties').doc(property.name).set({
      'name': property.name,
      'address': property.address,
      'rent': property.rent,
      'rentRecord': property.rentRecord,
    });
  }

  Future<List<Property>> getProperties() async {
    QuerySnapshot snapshot = await _firestore.collection('properties').get();
    return snapshot.docs.map((doc) {
      return Property(
        doc['name'],
        doc['address'],
        doc['rent'],
        doc['rentRecord'],
      );
    }).toList();
  }

  //get property
  Future<Property> getProperty(String id) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('properties').doc(id).get();
    return Property(
      snapshot['name'],
      snapshot['address'],
      snapshot['rent'],
      snapshot['rentRecord'],
    );
  }

  Future<void> updateProperty(String id, Property property) async {
    await _firestore.collection('properties').doc(id).update({
      'name': property.name,
      'address': property.address,
      'rent': property.rent,
      'rentRecord': property.rentRecord,
    });
  }

  Future<void> deleteProperty(String id) async {
    await _firestore.collection('properties').doc(id).delete();
  }
}
