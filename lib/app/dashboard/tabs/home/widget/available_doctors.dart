import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/utility/const/app_enums.dart';

class AvailableDoctors extends StatelessWidget {
  const AvailableDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Row(
      mainAxisAlignment: .spaceBetween,
        children: [
          "Doctors".toHeadingText(
            appFontStyle: AppFontStyle.semiBold,
            color: Colors.black
          ),

          "View All".toHeadingText(
            appFontStyle: AppFontStyle.regular,
            color: Colors.grey
          ),
        ],
      ).paddingSymmetric(horizontal: 15),

        ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: const [
            DoctorListCard(
              image:
                  "https://images.unsplash.com/photo-1607746882042-944635dfe10e",
              name: "Dr. Serena Gomes",
              speciality: "Medicine Specialist",
              rating: 4.8,
              experience: 8,
              fee: "₹600",
              isAvailable: true,
            ),
            DoctorListCard(
              image:
                  "https://images.unsplash.com/photo-1612349317150-e413f6a5b16d",
              name: "Dr. Alena Khan",
              speciality: "Cardiologist",
              rating: 4.6,
              experience: 5,
              fee: "₹800",
              isAvailable: false,
            ),
            DoctorListCard(
              image:
                  "https://images.unsplash.com/photo-1550831107-1553da8c8464",
              name: "Dr. Rajiv Mehta",
              speciality: "Neurologist",
              rating: 4.7,
              experience: 10,
              fee: "₹900",
              isAvailable: true,
            ),
          ],
        ),
      ],
    );
  }
}
class DoctorListCard extends StatelessWidget {
  final String image;
  final String name;
  final String speciality;
  final double rating;
  final int experience;
  final String fee;
  final bool isAvailable;

  const DoctorListCard({
    super.key,
    required this.image,
    required this.name,
    required this.speciality,
    required this.rating,
    required this.experience,
    required this.fee,
    required this.isAvailable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          /// DOCTOR IMAGE
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(image),
          ),

          const SizedBox(width: 12),

          /// INFO
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// NAME + STATUS
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAvailable
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isAvailable ? "Available" : "Busy",
                        style: TextStyle(
                          fontSize: 11,
                          color:
                              isAvailable ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                /// SPECIALITY
                Text(
                  speciality,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 6),

                /// RATING + EXPERIENCE
                Row(
                  children: [
                    const Icon(Icons.star,
                        size: 14, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$experience yrs exp",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// RIGHT SIDE (FEE + BUTTON)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                fee,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Book",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
