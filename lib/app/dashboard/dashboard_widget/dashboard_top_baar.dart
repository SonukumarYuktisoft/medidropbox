import 'package:flutter/cupertino.dart';
import 'package:get/utils.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

class DashboardTopBaar extends StatelessWidget {
  const DashboardTopBaar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                 "Find Your".toHeadingText(
                  appFontStyle: AppFontStyle.medium,
                  color: Colors.black87,
                  fontSize: 14
                 ),
            
                 "Specialist".toHeadingText(
                  appFontStyle: AppFontStyle.semiBold,
                  color: Colors.black,
                  fontSize: 17
                 )
            
              ],
            ),
          ),
       
         Row(
          children: [
            Icon(CupertinoIcons.search).asIconButton(onPressed: (){}),
            Icon(CupertinoIcons.chat_bubble).asIconButton(onPressed: (){}),
      
          ],
         )
        ],
      ).paddingOnly(left: 15,right: 5),
    );
  }
}