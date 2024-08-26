import 'package:flutter/material.dart';

import '../main.dart';

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.onTap})
      : super(key: key);

  final String title, subtitle;
  final Widget icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: mq.width * .45,
        child: Column(
          children: [
            InkWell(onTap: onTap, child: icon),
            SizedBox(
              height: 6,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 6,
            ),
            Text(subtitle,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightTest)),
          ],
        ));
  }
}
