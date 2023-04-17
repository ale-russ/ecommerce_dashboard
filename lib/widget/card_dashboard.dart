import 'package:flutter/material.dart';

class CardDashboard extends StatelessWidget {
  const CardDashboard(
      {super.key,
      this.cardName,
      this.icon,
      this.onPressed,
      this.cardColor,
      this.points});
  final String? cardName;
  final Widget? icon;
  final VoidCallback? onPressed;
  final int? points;
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        //elevation: 0,
        elevation: 50,
        shadowColor: Colors.black,
        color: cardColor,
        child: SizedBox(
          width: 182,
          height: 117,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 18.0),
                    child:
                        IconButton(iconSize: 15, onPressed: () {}, icon: icon!),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text('$points',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Text('$cardName',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
