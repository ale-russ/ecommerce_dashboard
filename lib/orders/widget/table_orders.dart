import 'dart:developer';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Tableorders extends StatelessWidget {
  Tableorders({super.key, this.cell1, this.cell2, this.cell3, this.cell4});
  final String? cell1;
  final String? cell2;
  final String? cell3;
  final String? cell4;

  Color? statusColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (cell3 == 'packing') {
      statusColor = Colors.amber;
    } else if (cell3 == 'delivered') {
      statusColor = Colors.blue;
    } else if (cell3 == 'completed') {
      statusColor = Colors.green;
    }
    return Container(
      color: secondaryColor,
      child: Table(
        border: TableBorder.all(width: 0, color: Colors.transparent),
        children: [
          TableRow(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
            ),
            children: [
              TableCell(
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(cell1!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis)),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(cell2!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(cell3!,
                        style: TextStyle(
                          color: statusColor!,
                        )),
                  ),
                ),
              ),
              TableCell(
                child: SizedBox(
                  height: 40,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(cell4!,
                        style: const TextStyle(
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
