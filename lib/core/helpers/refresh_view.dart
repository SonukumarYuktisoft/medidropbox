import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class RefreshView extends StatelessWidget {
  final String? title;
  final String? btntitle;
  final Color? btnColor;
  final EdgeInsetsGeometry? margin;
  final void Function()? onPressed;
  final IconData icon;
  const RefreshView({
    super.key,
    this.icon = Icons.refresh,
    this.btnColor,
    this.btntitle,
    this.title,
    this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: margin ?? const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (title ??"Somthings went wrong")
              .toHeadingText(
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
          if (onPressed != null)

          Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 14,
                    shadows: toIconShadow(),
                    color: Colors.black,
                  ).circularContainer(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                  ),
                  5.widthBox,
                  (btntitle ?? "Refresh")
                      .toHeadingText(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ],
              ).asElevatedButton(onPressed: onPressed),
        ],
      ),
    ),
  );
}
