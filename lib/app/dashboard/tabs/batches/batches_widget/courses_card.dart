// import 'package:flutter/cupertino.dart';
// import 'package:vidya_goal/app/helper/app_exporter.dart';
// import 'package:vidya_goal/app/helper/app_extensions/button_extension.dart';
// import 'package:vidya_goal/navigator/routes/app_routes/app_routes_name.dart';

// class CoursesCard extends StatelessWidget {
//   const CoursesCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Stack(

//           children: [
//             AppAssetImages.courseImage.toRadiusAssetImage(
//               radius: 5,
//               height: 181,
//               width: MediaQuery.widthOf(context)),
//               Positioned(
//                 top: 5.0,
//                 left: 5.0,
//                 child: Icon(CupertinoIcons.bookmark,size: 16,
                
//                 color: AppThemes.primaryColorSwatch[200],
//                 ).radiusContainer(
//                  radius: 7,
//                 color: Colors.white,
//                 height: 30,width: 30,
                

//               ))
//           ],
//         ),
//        7.heightBox,
//        "Arjuna NEET 4.0 2025".toHeadingText(
//         fontSize: 11.44,
//         fontWeight: FontWeight.w800
//        ),
//       5.heightBox,
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(radius: 4,backgroundColor: Theme.of(context).colorScheme.primary,),
//                8.widthBox,
//                "Started on 15th Sept 2025".toHeadingText(
//             fontSize: 12.44,
//             fontWeight: FontWeight.w400
//            )
//             ],
//           ),
//           AppString.buy.toHeadingText(
//             fontSize: 12,fontWeight: FontWeight.w700
//           ).asRoundedButton(
//              height: 30,
//             onPressed: (){})
          
//         ],
//       ),
//       5.heightBox,
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.watch_later_outlined,color: Colors.grey.shade400,size: 17,),
//              5.widthBox,
//               "84 hours".toHeadingText(
//                 fontSize: 12,fontWeight: FontWeight.w500,
//                 color: Colors.grey.shade400
//               )
            
//             ],
//           ),

//               Row(
//             children: [
//               Icon(Icons.star,
//               color: AppThemes.primarySwatch[300],
//               size: 17,),
//              5.widthBox,
//               "4.8 Ratings".toHeadingText(
//                 fontSize: 12,fontWeight: FontWeight.w500,
//                 color: Colors.grey.shade400
//               )
            
//             ],
//           ),
//             "Rs-4000/".toHeadingText(
//                 fontSize: 18,fontWeight: FontWeight.w700,
//                 color: Theme.of(context).primaryColor
//               )


//         ],
//       )
//       ],
//     ).radiusContainerWithBorder(
//       color: Colors.white,
//       padding: EdgeInsets.all(8),
//       borderColor: Colors.grey,
//       borderWidth: 0.3
//     ).asButton(onTap: (){
//       AppNavigators.pushNamed(AppRoutesName.competitiveExamsView);
//     });
//   }
// }