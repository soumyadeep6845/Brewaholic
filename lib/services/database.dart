import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  //Reference to a particular db collection
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  
}