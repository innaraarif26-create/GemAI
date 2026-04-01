// product_deletion_service.dart

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDeletionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> deleteProduct(String productId, String imagePath) async {
    try {
      // Delete the image from Firebase Storage
      await _storage.ref(imagePath).delete();
      print('Image deleted successfully from storage.');

      // Delete the product document from Firestore
      await _firestore.collection('products').doc(productId).delete();
      print('Product deleted successfully from Firestore.');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}