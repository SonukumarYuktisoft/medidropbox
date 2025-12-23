import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/extensions/text_extension.dart';

class NoMoreData extends StatelessWidget {
  final double size;
  final FontWeight weight;
  final Color txtColor;
  final Color bgColor;

  const NoMoreData({
    super.key,
    this.size = 10,
    this.weight = FontWeight.bold,
    this.bgColor = Colors.deepOrange,
    this.txtColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final t = "No More Data";
    final TextPainter text = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(text: t, style: TextStyle().appTextStyle()),
    )..layout();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        t
            .toHeadingText(
              fontSize: size,
              textAlign: TextAlign.center,
              fontWeight: weight,
              color: txtColor,
            )
            .radiusContainer(
              width: text.width,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 8),
              color: bgColor,
            ),
      ],
    );
  }
}
