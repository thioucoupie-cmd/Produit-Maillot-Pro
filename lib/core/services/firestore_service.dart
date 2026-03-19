import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:produit_maillot_pro/features/catalogue/models/product.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Product Management
  Stream<List<Product>> streamProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Product.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  Future<void> addProduct(Product product) async {
    await _db.collection('products').add(product.toMap());
  }

  // User Profile Management
  Future<void> saveUserProfile(String userId, Map<String, dynamic> data) async {
    await _db.collection('users').doc(userId).set(data, SetOptions(merge: true));
  }

  Future<DocumentSnapshot> getUserProfile(String userId) async {
    return await _db.collection('users').doc(userId).get();
  }

  // Order Management
  Future<void> createOrder(String userId, Map<String, dynamic> orderData) async {
    await _db.collection('orders').add({
      'userId': userId,
      ...orderData,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
