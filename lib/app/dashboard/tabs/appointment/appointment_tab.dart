import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_state.dart';
import 'package:medidropbox/app/models/bookings/myboookings_model.dart';
import 'package:medidropbox/core/extensions/date_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        60.heightBox,
        const Text(
          'My Appointment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),

        Expanded(
          child: BlocBuilder<AppointmentBloc, AppointmentState>(
            buildWhen: (previous, current) =>
                previous.bookingStatus != current.bookingStatus,
            builder: (context, state) {
              if (state.bookingStatus == ApiStatus.loading) {
                return DataLoading();
              }

              if (state.bookingStatus == ApiStatus.error) {
                return RefreshView(
                  title: state.mess,
                  onPressed: () =>
                      context.read<AppointmentBloc>().add(OnGetBooking()),
                );
              }

              if (state.bookingStatus == ApiStatus.success) {
                if (state.bookingData == null || state.bookingData!.isEmpty) {
                  return DataNotFound(title: "No appointments found");
                }

                return DefaultTabController(
                  length: 2,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const TabBar(
                            dividerColor: Colors.transparent,
                            labelColor: Colors.blue,
                            unselectedLabelColor: Colors.grey,
                            indicatorColor: Colors.blue,
                            tabs: [
                              Tab(text: "Upcoming"),
                              Tab(text: "Past"),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: TabBarView(
                              children: [
                                _AppointmentList(
                                  isUpcoming: true,
                                  data: state.bookingData!,
                                ),
                                _AppointmentList(
                                  isUpcoming: false,
                                  data: state.bookingData!,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// Floating Create Button
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: GestureDetector(
                          onTap: () {
                            AppNavigators.pushNamed(
                              AppRoutesName.createAppointmentView,
                            );
                          },
                          child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}

class _AppointmentList extends StatelessWidget {
  final bool isUpcoming;
  final List<MyBookings> data;

  const _AppointmentList({required this.isUpcoming, required this.data});

  @override
  Widget build(BuildContext context) {
    final filtered = data.where((e) {
      final queueStatus = e.queue?.status;

      if (queueStatus == null) return false;

      if (isUpcoming) {
        /// Upcoming tab → only WAITING
        return queueStatus.toUpperCase() == 'WAITING';
      } else {
        /// Past tab → everything except WAITING
        return queueStatus.toUpperCase() != 'WAITING';
      }
    }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          isUpcoming ? "No upcoming appointments" : "No past appointments",
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return AppointmentCard(
          isUpcoming: isUpcoming,
          booking: filtered[index],
        );
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final bool isUpcoming;
  final MyBookings booking;

  const AppointmentCard({
    super.key,
    required this.isUpcoming,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// -------- TOP ROW --------
          Row(
            children: [
              Expanded(
                flex: 3,
                child: InfoItem(
                  title: "Date",
                  value: booking.bookingDate != null
                      ? booking.bookingDate.readableDate
                      : "--",
                ),
              ),
              Expanded(
                flex: 2,
                child: InfoItem(
                  title: "Time",
                  value: booking.bookingTime ?? "--",
                ),
              ),
              Expanded(
                flex: 3,
                child: InfoItem(
                  title: "Doctor",
                  value: booking.doctorName ?? "--",
                ),
              ),
            ],
          ),

          16.heightBox,

          /// -------- BOTTOM ROW --------
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                flex: 3,
                child: InfoItem(
                  title: "Appointment Status",
                  value: booking.status ?? "--",
                ),
              ),
              Expanded(
                flex: 2,
                child: InfoItem(
                  title: "Place",
                  value: booking.hospitalName ?? "--",
                ),
              ),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      AppNavigators.pushNamed(
                        AppRoutesName.bookingDetailsView,
                        extra: booking.id, // 🔥 IMPORTANT
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUpcoming ? Colors.green : Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "View",
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
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

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
