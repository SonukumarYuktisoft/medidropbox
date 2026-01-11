import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_state.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';
import 'package:medidropbox/core/helpers/app_loader/overlay_loading.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class BookingDetails extends StatefulWidget {
  final String bookingId;
  const BookingDetails(this.bookingId, {super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentBloc>().add(OnGetBookingByid(widget.bookingId));
  }

  String _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'CONFIRMED':
        return '#4CAF50';
      case 'WAITING':
        return '#FF9800';
      case 'COMPLETED':
        return '#2196F3';
      case 'CANCELLED':
        return '#F44336';
      default:
        return '#9E9E9E';
    }
  }

  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        leadColor: Colors.white,
        title: "Booking Details",
        titleColor: Colors.white,
      ),
      body: BlocListener<AppointmentBloc, AppointmentState>(
        listenWhen: (previous, current) => previous.shareBookingStatus!=current.shareBookingStatus,
        listener: (context, state) {
          if(state.shareBookingStatus==ApiStatus.loading){
            showOverlayLoading(context);
          }
          if(state.shareBookingStatus==ApiStatus.error){
           AppNavigators.pop();
           AppSnackbar.showError(state.mess);
          }
           if(state.shareBookingStatus==ApiStatus.success){
           AppNavigators.pop();
           AppSnackbar.showSuccess(state.mess);
          }
        },
       child: BlocBuilder<AppointmentBloc, AppointmentState>(
          buildWhen: (previous, current) =>
              previous.bookingDetailsStatus != current.bookingDetailsStatus,
          builder: (context, state) {
            if (state.bookingDetailsStatus == ApiStatus.loading) {
              return DataLoading();
            }
            if (state.bookingDetailsStatus == ApiStatus.error) {
              return RefreshView(
                onPressed: () => context.read<AppointmentBloc>().add(
                  OnGetBookingByid(widget.bookingId),
                ),
              );
            }
            if (state.bookingDetailsStatus == ApiStatus.success) {
              if (state.bookingDetails == null) {
                return DataNotFound();
              }

              final booking = state.bookingDetails!;
              final payment = booking.payment;
              final queue = booking.queue;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Status Card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  _hexToColor(
                                    _getStatusColor(booking.status.toString()),
                                  ),
                                  _hexToColor(
                                    _getStatusColor(booking.status.toString()),
                                  ).withOpacity(0.7),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: _hexToColor(
                                    _getStatusColor(booking.status.toString()),
                                  ).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 48,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  booking.status.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Booking ID: #${booking.id}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Doctor Details
                          _buildSectionCard(
                            icon: Icons.medical_services,
                            iconColor: Colors.blue,
                            title: 'Doctor Details',
                            children: [
                              _buildInfoRow(
                                'Doctor Name',
                                booking.doctorName.toString(),
                              ),
                              _buildInfoRow(
                                'Hospital',
                                booking.hospitalName.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Patient Details
                          _buildSectionCard(
                            icon: Icons.person,
                            iconColor: Colors.green,
                            title: 'Patient Details',
                            children: [
                              _buildInfoRow(
                                'Patient Name',
                                booking.patientName.toString(),
                              ),
                              if (booking.patientPhone != null)
                                _buildInfoRow(
                                  'Phone',
                                  booking.patientPhone.toString(),
                                ),
                              if (booking.patientEmail != null)
                                _buildInfoRow(
                                  'Email',
                                  booking.patientEmail.toString(),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Appointment Details
                          _buildSectionCard(
                            icon: Icons.calendar_today,
                            iconColor: Colors.orange,
                            title: 'Appointment Details',
                            children: [
                              _buildInfoRow(
                                'Date',
                                "${booking.bookingDate!.year}-${booking.bookingDate!.month}-${booking.bookingDate!.day}",
                              ),
                              _buildInfoRow(
                                'Time',
                                booking.bookingTime.toString(),
                              ),
                              _buildInfoRow(
                                'Contact',
                                booking.phoneNumber.toString(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Queue Information
                          if (queue != null)
                            _buildSectionCard(
                              icon: Icons.numbers,
                              iconColor: Colors.purple,
                              title: 'Queue Information',
                              children: [
                                _buildInfoRow(
                                  'Queue Number',
                                  queue.queueNumber.toString(),
                                ),
                                _buildInfoRow(
                                  'Queue Status',
                                  queue.status.toString(),
                                ),
                              ],
                            ),
                          if (queue != null) const SizedBox(height: 16),

                          // Payment Details
                          if (payment != null)
                            _buildSectionCard(
                              icon: Icons.payment,
                              iconColor: Colors.teal,
                              title: 'Payment Details',
                              children: [
                                _buildInfoRow(
                                  'Payment Mode',
                                  payment.paymentMode.toString(),
                                ),
                                _buildInfoRow(
                                  'Transaction ID',
                                  payment.transactionId ?? 'N/A',
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  'Total Bill',
                                  '₹${payment.totalBill}',
                                  valueStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                _buildInfoRow(
                                  'Discount',
                                  '- ₹${payment.discount}',
                                  valueStyle: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                _buildInfoRow(
                                  'Taxable Amount',
                                  '₹${payment.taxableAmount}',
                                  valueStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                _buildInfoRow(
                                  'GST',
                                  '₹${payment.gst}',
                                  valueStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                ),
                                const Divider(height: 24),
                                _buildInfoRow(
                                  'Total Amount',
                                  '₹${payment.totalAmount}',
                                  valueStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  // Share Button at Bottom
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SafeArea(
                      child: SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            context.read<AppointmentBloc>().add(
                              OnShareBooking(booking.id.toString()),
                            );
                          },
                          label: const Text(
                            'Share Booking',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {TextStyle? valueStyle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style:
                  valueStyle ??
                  const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
