import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/product.dart';

class UploadNotifier extends AutoDisposeNotifier<Product> {
  @override
  build() {
    // ref.onDispose(() {

    // })
    return Product();
  }

  Future<bool> uploadImage(BuildContext context, String? name, String? price,
      File? imageFile) async {
    String? imageUrl;
    final FirebaseStorage storage = FirebaseStorage.instance;
    final fileName = '${DateTime.now().microsecondsSinceEpoch}';
    final Reference ref = storage.ref().child('images/$fileName');
    final UploadTask uploadTask = ref.putFile(imageFile!);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() {
      log('Successfull');
    });

    imageUrl = await snapshot.ref.getDownloadURL();

    final DocumentReference<Map<String, dynamic>> images =
        FirebaseFirestore.instance.collection('products').doc(fileName);

    final prodcuts = Product(name: name, price: price, imageURL: imageUrl);

    try {
      final json = prodcuts.toMap();
      await images.set(json);
      log('uploaded successfull');

      return true;
    } catch (e) {
      log('error: ${e.toString}');
      return false;
    }
  }

  void disposeUploadedData() {}
}
