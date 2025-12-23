import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/extensions/text_extension.dart';

class DataNotFound extends StatelessWidget {
  final String? title;
  final bool showIcon;
  final Color iconColor;
  final double iconSize;
  final double topPadding;
  final IconData icon;
  const DataNotFound({
    super.key,
    this.title,
    this.showIcon = false,
    this.iconColor = Colors.black,
    this.iconSize = 60,
    this.topPadding = 0,
    this.icon =  Icons.assignment_outlined,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: topPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showIcon)
              Icon(
                icon,
                size: iconSize,
                color: iconColor,
                shadows: toIconShadow(),
              ),
            (title ?? 'Data Not Found').toHeadingText(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
