// import 'package:vidya_goal/app/dashboard/tabs/batches/batches_widget/courses_card.dart';
// import 'package:vidya_goal/app/helper/app_exporter.dart';
// import 'package:vidya_goal/app/helper/app_extensions/padding_extension.dart';

// class CoursesList extends StatelessWidget {
//   const CoursesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Expanded(
//       child: SingleChildScrollView(
//         physics: BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AppString.popularCourses.toHeadingText(
//               fontSize: 18,
//               fontWeight: FontWeight.w600
//             ).topLeftAlign().paddingSymmetric(horizontal: 15),
//             2.heightBox,
//             ListView.separated(
//               padding: EdgeInsets.only(left: 15,right: 15,bottom: 15),
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               separatorBuilder: (_,i)=>SizedBox(height: 15),
//                itemCount: 15,
//               itemBuilder: (ctx,i)=>CoursesCard()
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }