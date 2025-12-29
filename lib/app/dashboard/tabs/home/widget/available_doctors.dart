import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/doctor_shimmer/doctor_cards_shimmer/doctor_grid_card_shimmer.dart';
import 'package:medidropbox/core/helpers/app_shimmer/vertical_list_shimmer.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class AvailableDoctors extends StatelessWidget {
  const AvailableDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) =>
          previous.allDoctorStatus != current.allDoctorStatus,

      builder: (context, state) {
        if (state.allDoctorStatus == ApiStatus.error) {
          return RefreshView(
            onPressed: () => context.read<HomeBloc>().add(OnGetAllDoctors('1')),
          ).radiusContainer(
            color: Colors.grey.shade300,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 40),
          );
        } else if (state.allDoctorStatus == ApiStatus.loading) {
          return VerticalListShimmer();
        } else if (state.allDoctorStatus == ApiStatus.success &&
            (state.allDoctorList == null || state.allDoctorList!.isEmpty)) {
          return Column(
            children: [
              const Icon(
                Icons.medical_services_outlined,
                size: 48,
                color: Colors.grey,
              ),
              8.heightBox,
              "No doctors available".toHeadingText(color: Colors.grey),
            ],
          ).paddingAll(20);
        } else if (state.allDoctorStatus == ApiStatus.success &&
            state.allDoctorList != null &&
            state.allDoctorList!.isNotEmpty) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "Doctors".toHeadingText(
                    appFontStyle: AppFontStyle.semiBold,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppSnackbar.showInfo(' Coming soon!');
                    },
                    child: "View All".toHeadingText(
                      appFontStyle: AppFontStyle.regular,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 15),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                itemCount: state.allDoctorList!.length > 3
                    ? 3
                    : state.allDoctorList!.length,
                itemBuilder: (context, index) {
                  final doctor = state.allDoctorList![index];
                  return DoctorListCard(doctor: doctor);
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class DoctorListCard extends StatelessWidget {
  final AllDoctorsModel doctor;

  const DoctorListCard({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to doctor detail page
        AppNavigators.pushNamed(
          AppRoutesName.doctorDetailsView,
          extra: doctor.id.toString(),
        );
      },
      child: Container(
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
            doctor.profilePhotoUrl.toCircularImage(size: 70),

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
                          doctor.name,
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
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: doctor.isActive
                              ? Colors.green.withOpacity(0.1)
                              : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          doctor.isActive ? "Available" : "Busy",
                          style: TextStyle(
                            fontSize: 11,
                            color: doctor.isActive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  /// SPECIALITY
                  Text(
                    doctor.specialty,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),

                  const SizedBox(height: 6),

                  /// RATING + EXPERIENCE
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        doctor.rating.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${doctor.servedPatientCount}+ patients",
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
                  "₹${doctor.fees.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Show booking dialog
                    DoctorBookingDialog.show(context, doctor);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Update DoctorBookingDialog to accept AllDoctorsModel
class DoctorBookingDialog {
  static void show(BuildContext context, AllDoctorsModel doctor) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              'Book Appointment'.toHeadingText(
                fontSize: 20,
                appFontStyle: AppFontStyle.bold,
              ),
              16.heightBox,
              'Consultation Fee: ₹${doctor.fees.toStringAsFixed(0)}'
                  .toHeadingText(fontSize: 16),
              24.heightBox,
              Row(
                children: [
                  if (doctor.allowRemote)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          // TODO: Implement remote booking
                        },
                        icon: const Icon(Icons.videocam),
                        label: const Text('Remote'),
                      ),
                    ),
                  if (doctor.allowRemote) 16.widthBox,
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        // TODO: Implement in-person booking
                      },
                      icon: const Icon(Icons.location_on),
                      label: const Text('In-person'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
