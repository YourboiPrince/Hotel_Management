import 'package:cloud_firestore/cloud_firestore.dart'; // Import profile screen

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Get a reference to the Firestore database
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> updateHotelData(String simba, String name, int strength) async {
    return await userCollection.doc(uid).set({
      'simba': simba,
      'name': name,
      'strength': strength,
    });
  }
}
