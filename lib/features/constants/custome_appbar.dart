import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.users,
    this.title,
    this.isCenterTile = false,
    this.fontSize = 16,
  });

  Size get preferredSize => const Size.fromHeight(50);

  final User? users;
  final String? title;
  final bool? isCenterTile;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: isCenterTile!,
      backgroundColor: secondaryColor,
      title: Text(
        title ?? "",
        style: TextStyle(fontSize: fontSize),
      ),
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              users?.displayName ?? "",
              style: const TextStyle(fontSize: 12),
            ),
          ),
        )
      ],
    );
  }
}
