import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:ecommerce_dashboard/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Addproduct extends ConsumerStatefulWidget {
  const Addproduct({super.key});

  @override
  ConsumerState<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends ConsumerState<Addproduct> {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  File? _imageFile;
  String? _imageUrl;
  final User users = FirebaseAuth.instance.currentUser!;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    // final pickedFile = await picker.getImage(source: source);
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: const Text(
          'Add product',
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${users.email}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _imageFile != null
                  ? Image.file(_imageFile!,
                      height: 200, width: 400, fit: BoxFit.cover)
                  : Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: _imageFile == null
                          ? const Center(
                              child: Text('No image selected.',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            )
                          : Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                    ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    height: 20,
                    width: 120,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          side: const BorderSide(color: primaryColor, width: 2),
                        ),
                        onPressed: () => _getImage(ImageSource.gallery),
                        child: const Text('Select image',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black)))),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: name,
                style: const TextStyle(color: Colors.white),
                minLines: 1,
                maxLines: 15,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'name description',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: price,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter price',
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: _uploadImage,
                    child: const Text('Add product'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final fileName = '${DateTime.now().microsecondsSinceEpoch}';
    final Reference ref = storage.ref().child('images/$fileName');
    final UploadTask uploadTask = ref.putFile(_imageFile!);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() {
      print('sucessfully');
    });
    final String downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      _imageUrl = downloadUrl.toString();
      print('image file$_imageUrl');
    });

    final DocumentReference<Map<String, dynamic>> images =
        FirebaseFirestore.instance.collection('products').doc('$fileName');

    final String namedesc = name.text;
    final String totalprice = price.text;
    final imageUrl = _imageUrl;

    final products = Product(
      name: namedesc,
      price: totalprice,
      imageURL: imageUrl.toString(),
    );

    try {
      final json = products.toMap();
      await images.set(json);
      name.clear();
      price.clear();
      setState(() {
        _imageFile = null;
        _imageUrl = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('product uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to upload product')),
      );
    }
  }
}
