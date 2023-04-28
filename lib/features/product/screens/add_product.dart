import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_dashboard/features/constants/constants.dart';
import 'package:ecommerce_dashboard/features/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../constants/custome_appbar.dart';
import '../../notifications/notification_message.dart';
import '../provider/upload_info_provider.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key, this.id});

  final int? id;

  @override
  ConsumerState<AddProductPage> createState() => _AddproductState();
}

class _AddproductState extends ConsumerState<AddProductPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  File? _imageFile;
  // String? _imageUrl;
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
    var uploaStatus = ref.watch(uploadStatusProvider);
    log('uploadStatus: $uploaStatus');

    bool isLoding = false;

    ref.listen(uploadStatusProvider, (previous, status) {
      if (status.isLoading) isLoding = true;
    });

    return Scaffold(
      appBar: CustomAppBar(users: users, title: 'Add Products', fontSize: 14),
      body: Stack(
        children: [
          Padding(
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
                              side: const BorderSide(
                                  color: primaryColor, width: 2),
                            ),
                            onPressed: () => _getImage(ImageSource.gallery),
                            child: const Text('Select image',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black)))),
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
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        // onPressed: _uploadImage,
                        onPressed: () async {
                          var scaffoldMessenger = ScaffoldMessenger.of(context);
                          var status = await ref
                              .read(uploadInfoProvider.notifier)
                              .uploadImage(
                                  context, name.text, price.text, _imageFile);
                          if (status) {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text(
                              'Uploaded Successfully',
                              style: TextStyle(color: Colors.green),
                            )));
                          } else {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text(
                              'Opps... Something went wrong. Please try again',
                              style: TextStyle(color: Colors.red),
                            )));
                          }
                        },
                        child: const Text('Add product'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoding)
            const CircularProgressIndicator(
              color: Colors.amber,
            ),
        ],
      ),
    );
  }
}
