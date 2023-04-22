import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

AppBar adminAppbar({
  final String? user,
  final String? title,
}) {
  return AppBar(
    backgroundColor: secondaryColor,
    leading: Container(
      color: Colors.green,
      width: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title!,
        style: TextStyle(color: Colors.black26),
      ),
    ),
    actions: [
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '${user}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      )
    ],
  );
}
