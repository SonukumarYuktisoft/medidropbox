import 'package:medidropbox/core/helpers/app_export.dart';
String formatDate(String date) {
  final d = DateTime.parse(date);
  return "${d.day}-${d.month}-${d.year}";
}

String formatTime(String time) {
  final t = DateTime.parse("1970-01-01 $time");
  return "${t.hour > 12 ? t.hour - 12 : t.hour}:${t.minute.toString().padLeft(2, '0')} ${t.hour >= 12 ? 'PM' : 'AM'}";
}

class BookingConfirmationView extends StatelessWidget {
  final Map<String, dynamic> data;

  const BookingConfirmationView(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final doctor = data['doctorName'] ?? '-';
    final hospital = data['hospitalName'] ?? '-';
    final appointmentId = data['id'].toString();
    final bookingDate = formatDate(data['bookingDate']);
    final bookingTime = formatTime(data['bookingTime']);
    final queueNumber = data['queue']?['queueNumber']?.toString() ?? '-';
    final paymentMode = data['payment']?['paymentMode'] ?? '-';
    final amount = data['payment']?['totalAmount']?.toString() ?? '0';
    final status = data['status'];

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xffF4F6FA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Spacer(),
      
              /// SUCCESS ICON
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 60,
                  color: Colors.green,
                ),
              ),
      
              const SizedBox(height: 16),
      
              /// TITLE
              const Text(
                "Appointment Confirmed",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
      
              const SizedBox(height: 6),
      
              Text(
                "Your appointment has been successfully booked",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
      
              const SizedBox(height: 24),
      
              /// DETAILS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _detailRow("Appointment ID", "#APT-$appointmentId"),
                    const Divider(),
      
                    _detailRow("Doctor", doctor),
                    _detailRow("Hospital", hospital),
      
                    const Divider(),
      
                    _detailRow("Date", bookingDate),
                    _detailRow("Time", bookingTime),
                    _detailRow("Queue No.", queueNumber),
      
                    const Divider(),
      
                    /// PAYMENT ROW (Highlighted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Payment",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹$amount",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              paymentMode,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      
              const SizedBox(height: 16),
      
              /// STATUS BADGE
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      
              const SizedBox(height: 20),
      
              /// INFO NOTE
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Colors.blue),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Please arrive 10 minutes early and carry your ID proof.",
                        style: TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
      
              const Spacer(),
      
              /// ACTION BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    AppNavigators.pushNamedAndRemoveUntil(
                        AppRoutesName.dashboardView);
                  },
                  child: const Text(
                    "Go to Home",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
