import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorTab extends StatelessWidget {
  const DoctorTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> doctors = [
      {
        "name": "Dr. Serena rose",
        "specialist": "Medicine Specialist",
        "experience": "8 Years",
        "patients": "1.06K",
        "image": "https://www.maxathome.in/img/doctorVisitBG.png",
        "phone": "1234567890",
        "patient": '3.1k',
        "review": '4.5k',
      },
      {
        "name": "Dr. Farida Rahman",
        "specialist": "Medicine Specialist",
        "experience": "7 Years",
        "patients": "3.09K",
        "image":
            "https://res.cloudinary.com/de8apumdp/image/upload/v1766326431/samples/smile.jpg",
        "phone": "1234567890",
        "patient": '3.9k',
        "review": '5k',
      },
      {
        "name": "Dr. Kiran Shukla",
        "specialist": "Medicine Specialist",
        "experience": "6 Years",
        "patients": "1.08K",
        "image": "https://i.pravatar.cc/150?img=5",
        "phone": "1234567890",
        "about": 'speacialistnis baby care since 1988',
        "patient": '3.9k',
        "review": '1.9k',
      },
      {
        "name": "Dr. Masuda Khan",
        "specialist": "Medicine Specialist",
        "experience": "1 Year",
        "patients": "2.10K",
        "image": "https://i.pravatar.cc/150?img=8",
        "phone": "1234567890",
        "about": 'goldmedalist from america in medicine',
        "patient": '2.9k',
        "review": '6.9k',
      },
      {
        "name": "Dr. Serena rose",
        "specialist": "Medicine Specialist",
        "experience": "8 Years",
        "patients": "1.06K",
        "image": "https://i.pravatar.cc/150?img=1",
        "phone": "1234567890",
        "about": 'top 10 in experience in critical care unit',
        "patient": '6.9k',
        "review": '6k',
      },
      {
        "name": "Dr. Farida Rahman",
        "specialist": "Medicine Specialist",
        "experience": "7 Years",
        "patients": "3.09K",
        "image": "https://i.pravatar.cc/150?img=9",
        "phone": "1234567890",
        "about": 'top 10 in experience in critical care examination',
        "patient": '1.9k',
        "review": '2.1k',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Top category tabs (UI only)
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _tabItem("Pediatrician", true),
              _tabItem("Neurosurgeon", false),
              _tabItem("Cardiologist", false),
              _tabItem("Psychiatrist", false),
            ],
          ).paddingSymmetric(horizontal: 20),
        ),

        const SizedBox(height: 16),

        /// Doctor Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final d = doctors[index];
              return GestureDetector(
                onTap: () {
                  // Get.to(() => DoctorDetails(doctor: d));
                  AppNavigators.pushNamed(
                    AppRoutesName.doctorDetailsView,
                    extra: d,
                  );
                },
                child: _doctorCard(d),
              );
            },
          ),
        ),
      ],
    );
  }

  /// Category Tab
  Widget _tabItem(String title, bool selected) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          if (selected)
            Container(
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }

  /// Doctor Card
  Widget _doctorCard(Map<String, dynamic> d) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
         
          Center(child: d["image"].toString().toCircularImage(size: 70)),

          const SizedBox(height: 10),

          /// Flexible content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d["name"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      d["specialist"],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          size: 13,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),

                /// Bottom info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Experience", style: _labelStyle()),
                    Text(d["experience"], style: _valueStyle()),
                    const SizedBox(height: 4),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle() => const TextStyle(fontSize: 11, color: Colors.grey);

  TextStyle _valueStyle() =>
      const TextStyle(fontSize: 13, fontWeight: FontWeight.w600);
}
