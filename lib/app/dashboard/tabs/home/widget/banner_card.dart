
import 'package:medidropbox/core/helpers/app_export.dart';
class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(16),
      height: 170,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff2F80ED),
            Color(0xff56CCF2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          /// LEFT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Find Your Specialist"
                    .toHeadingText(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),

                6.heightBox,

                "Cardiologist • Neurologist • Pediatrician"
                    .toHeadingText(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),

                10.heightBox,

                /// Doctor info chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.verified,
                          color: Colors.white, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "120+ Verified Doctors",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// CTA BUTTON
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.calendar_today,
                          size: 14, color: Color(0xff2F80ED)),
                      SizedBox(width: 6),
                      Text(
                        "Book Appointment",
                        style: TextStyle(
                          color: Color(0xff2F80ED),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          /// RIGHT IMAGE
          "https://cdn-icons-png.flaticon.com/128/6660/6660279.png"
              .toImage(height: 120,width: 100),
        ],
      ),
    );
  }
}
