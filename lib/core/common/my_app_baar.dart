import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/text_extension.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final Color? color;
  final Color leadColor;
  final Color titleColor;
  final double titleSize;
  final bool? isShowBorder;
  final bool isShowLeadIcon;
  final bool centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const MyAppBar({
    super.key,
    this.title,
    this.color,
    this.isShowBorder,
    this.actions,
    this.titleWidget,
    this.isShowLeadIcon = true,
    this.centerTitle = false,
    this.titleColor = Colors.black,
    this.leadColor = Colors.black,
    this.bottom,
    this.titleSize=16
  });

  @override
  Widget build(BuildContext context) {
  
    return AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: isShowLeadIcon,
      iconTheme: IconThemeData(color: leadColor),
      backgroundColor: color ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: 0,
      title: titleWidget ??(title ?? '').toHeadingText(
        fontSize: titleSize,
        fontWeight: FontWeight.w500,
        color: titleColor,
      ),
      actions: actions,
      bottom: (bottom != null || (isShowBorder ?? false))
          ? PreferredSize(
              preferredSize: Size.fromHeight(
                (bottom?.preferredSize.height ?? 0) + ((isShowBorder ?? false) ? 0.5 : 0),
               
             
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (bottom != null) bottom!,
                  if (isShowBorder ?? false)
                    const Divider(height: 0.5, thickness: 0.5, color: Colors.grey),
                ],
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0) + ((isShowBorder ?? false) ? 0.5 : 0));
}