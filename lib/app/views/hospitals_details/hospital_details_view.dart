import 'package:medidropbox/core/common/book_appointment_btn.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalDetailsView extends StatelessWidget {
  const HospitalDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      /// STICKY CTA
      bottomNavigationBar: BookAppointmentBtn(),/* Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.calendar_today, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                "Book Appointment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ), */

      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER IMAGE
            Stack(
              children: [
                AppNetworkImages.hospital.toImage(
                  width: double.infinity,
                  height: MediaQuery.heightOf(context) / 2.7,
                  fit: BoxFit.cover,
                ),
        
                /// GRADIENT
                Container(
                  height: MediaQuery.heightOf(context) / 2.7,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.45),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
        
                /// BACK BUTTON
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppBackBtn(),
                ),
              ],
            ),
        
            /// CONTENT
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// CATEGORY + RATING
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _chip("Hospital"),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 16),
                          4.widthBox,
                          "3.8".toHeadingText(
                            appFontStyle: AppFontStyle.semiBold,
                          ),
                          4.widthBox,
                          "(365 Reviews)".toHeadingText(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                      
                  12.heightBox,
                      
                  /// NAME
                  "Woodland Multispeciality Hospital"
                      .toHeadingText(
                          fontSize: 20,
                          appFontStyle: AppFontStyle.bold),
                      
                  8.heightBox,
                      
                  /// LOCATION
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      6.widthBox,
                      "Sector 62, Noida, Uttar Pradesh"
                          .toHeadingText(color: Colors.grey),
                    ],
                  ),
                      
                  20.heightBox,
                      
                  /// QUICK INFO
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _InfoTile(
                          icon: Icons.local_hospital,
                          title: "Departments",
                          value: "24+"),
                      _InfoTile(
                          icon: Icons.people,
                          title: "Doctors",
                          value: "120+"),
                      _InfoTile(
                          icon: Icons.schedule,
                          title: "Open",
                          value: "24x7"),
                    ],
                  ),
                      
                  24.heightBox,
                      
                  /// FACILITIES
                  "Facilities".toHeadingText(
                      appFontStyle: AppFontStyle.semiBold),
                  10.heightBox,
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: const [
                      _FacilityChip(Icons.biotech, "Lab"),
                      _FacilityChip(Icons.local_hospital, "ICU"),
                      _FacilityChip(Icons.local_parking, "Parking"),
                      _FacilityChip(Icons.car_crash, "Ambulance"),
                      _FacilityChip(Icons.local_cafe, "Cafeteria"),
                    ],
                  ),
                      
                  24.heightBox,
                      
                  /// WORKING HOURS
                  _sectionCard(
                    icon: Icons.schedule,
                    title: "Working Hours",
                    subtitle: "Open 24x7 (Emergency Available)",
                  ),
                      
                  24.heightBox,
                      
                  /// DOCTORS PREVIEW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Available Doctors".toHeadingText(
                          appFontStyle: AppFontStyle.semiBold),
                      "View All".toHeadingText(
                          color: Colors.blue, fontSize: 13),
                    ],
                  ),
                      
                  12.heightBox,
                  _DoctorMiniCard(
                      name: "Dr. Serena Gomes",
                      speciality: "Medicine Specialist"),
                  _DoctorMiniCard(
                      name: "Dr. Alena Khan",
                      speciality: "Cardiologist"),
                      
                  24.heightBox,
                      
                  /// MAP
                  "Location".toHeadingText(
                      appFontStyle: AppFontStyle.semiBold),
                  10.heightBox,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AppNetworkImages.mapPreview.toImage(
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                      
                  24.heightBox,
                      
                  /// REVIEWS
                  "Patient Reviews".toHeadingText(
                      appFontStyle: AppFontStyle.semiBold),
                  12.heightBox,
                  _ReviewCard(),
                  _ReviewCard(),
                      
                  40.heightBox,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: text.toHeadingText(
        color: Colors.blue,
        fontSize: 12,
        appFontStyle: AppFontStyle.semiBold,
      ),
    );
  }

  Widget _sectionCard(
      {required IconData icon,
      required String title,
      required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title.toHeadingText(
                  appFontStyle: AppFontStyle.semiBold),
              subtitle.toHeadingText(color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }
}

/// ================== SMALL WIDGETS ==================

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoTile(
      {required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue.withOpacity(0.1),
          child: Icon(icon, color: Colors.blue),
        ),
        6.heightBox,
        value.toHeadingText(appFontStyle: AppFontStyle.semiBold),
        title.toHeadingText(color: Colors.grey, fontSize: 12),
      ],
    );
  }
}

class _FacilityChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _FacilityChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          6.widthBox,
          label.toHeadingText(fontSize: 12),
        ],
      ),
    );
  }
}

class _DoctorMiniCard extends StatelessWidget {
  final String name;
  final String speciality;

  const _DoctorMiniCard(
      {required this.name, required this.speciality});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, color: Colors.white),
          ),
          10.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              name.toHeadingText(
                  appFontStyle: AppFontStyle.semiBold),
              speciality.toHeadingText(
                  fontSize: 12, color: Colors.grey),
            ],
          )
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey.shade100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Rahul Sharma".toHeadingText(
              appFontStyle: AppFontStyle.semiBold),
          6.heightBox,
          "Very good hospital with supportive staff and experienced doctors."
              .toHeadingText(color: Colors.grey, fontSize: 13),
        ],
      ),
    );
  }
}
