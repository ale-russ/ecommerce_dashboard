import 'package:ecommerce_dashboard/constants/constants.dart';
import 'package:flutter/material.dart';

class Imagewidget extends StatelessWidget {
  const Imagewidget({super.key, this.imageurl});
  final String? imageurl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      // height: 200.0,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sPadding),
        border: Border.all(color: Colors.transparent, width: 2),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage('$imageurl'),
        ),
      ),
    );
  }
}
