import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_progress_indicators/simple_progress_indicators.dart';

import '../../constants/constants.dart';
import '../../product/widget/product_widget.dart';

class Dashboardwidget extends StatelessWidget {
  const Dashboardwidget(
      {super.key,
      this.count,
      required this.title,
      this.textcontainercolor = Colors.greenAccent,
      this.containercolor = containercolors,
      this.value});
  final int? count;
  final String title;
  final Color? textcontainercolor;
  final Color? containercolor;
  final double? value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.all(8),
        width: 180,
        height: 160,
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(sPadding),
          border: Border.all(color: secondaryColor, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: containercolor,
                          borderRadius: BorderRadius.circular(sPadding),
                          // border: Border.all(color: containercolor, width: 2),
                        ),
                        child: Icon(
                          Icons.upload_file_rounded,
                          color: textcontainercolor,
                        )),
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      iconSize: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(height: sPadding),
              Expanded(
                child: DescText(
                  name: title,
                ),
              ),
              const SizedBox(height: sPadding),
              ProgressBar(
                backgroundColor: containercolors,
                width: 400,
                value: value,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.yellowAccent, Colors.deepOrange],
                ),
              ),
              const SizedBox(height: sPadding),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: containercolor,
                        borderRadius: BorderRadius.circular(sPadding),
                        // border: Border.all(color: containercolor, width: 2),
                      ),
                      child: Center(
                          child: Text(count!.toString(),
                              style: TextStyle(color: textcontainercolor)))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
