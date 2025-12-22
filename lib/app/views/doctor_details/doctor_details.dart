import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorDetails extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetails({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          doctor["name"],
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            /// Doctor Image
            "https://www.maxathome.in/img/doctorVisitBG.png".toImage(
              width: double.infinity,
              height: MediaQuery.heightOf(context)/3
            ),
           

            const SizedBox(height: 20),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(Icons.call, "Voice Call", Colors.blue),
                _actionButton(Icons.videocam, "Video Call", Colors.purple),
                _actionButton(Icons.message, "Message", Colors.orange),
              ],
            ),

            const SizedBox(height: 24),

            /// Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor["specialist"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Good Health Clinic, MBBS, FCPS",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 10),

                  /// Rating
                  Row(
                    children: List.generate(
                      5,
                      (index) =>
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// About
                  const Text(
                    "About Doctor",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    doctor["about"] ??
                        "Experienced medical professional dedicated to patient care.",
                    style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                  ),

                  const SizedBox(height: 24),

                  /// Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _statItem("Patients", doctor["patient"] ?? "0"),
                      _statItem("Experience", doctor["experience"]),
                      _statItem("Reviews", doctor["review"] ?? "0"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// Book Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  AppNavigators.pushNamed(AppRoutesName.bookAppointmentView);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Book an Appointment",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Helpers
  Widget _actionButton(IconData icon, String text, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        height: 34,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color,size: 15,),
            const SizedBox(width: 5),
            Expanded(child:text.toHeadingText(color: color,textAlign: TextAlign.center,fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(title, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}
