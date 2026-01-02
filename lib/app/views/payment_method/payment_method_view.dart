import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/models/common_model/book_appointment_model.dart';
import 'package:medidropbox/app/views/payment_method/bloc/peyment_method_bloc.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/overlay_loading.dart';
import 'package:medidropbox/core/utility/const/price_formate.dart';

class PaymentMethodView extends StatelessWidget {
  final BookAppointmentModel model;
  const PaymentMethodView(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    final double consultationFee = double.parse(model.docFees); // taxable
    final double gstAmount = consultationFee * 0.18;
    final double totalPayable = consultationFee + gstAmount;
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      /// PAY BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child:
            Text(
              "Pay ${AppPriceFormatter.indian(totalPayable)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ).asElevatedButton(
              onPressed: () {
                context.read<PeymentMethodBloc>().add(
                  OnCreateBooking(
                    gst: gstAmount.toString(),
                    taxableAmount: consultationFee.toString(),
                    totalAmount: totalPayable.toString(),
                    hosId: model.hosId,
                    docId: model.docId,
                  ),
                );
              },
            ),
      ),

      body: SafeArea(
        child: BlocListener<PeymentMethodBloc, PeymentMethodState>(
          listenWhen: (previous, current) =>
              previous.createBookingStatus != current.createBookingStatus,
          listener: (context, state) {
            if (state.createBookingStatus == ApiStatus.loading) {
              showOverlayLoading(context);
            }
            if (state.createBookingStatus == ApiStatus.error) {
              AppNavigators.pop();
              AppSnackbar.showError(state.mess);
            }
            if (state.createBookingStatus == ApiStatus.success) {
              context.read<HomeBloc>().add(OnInitiateMyQueueApi());
              AppNavigators.pop();
              AppNavigators.pushNamed(AppRoutesName.bookingConfirmView,extra: state.data);
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                /// PAYMENT METHODS
                const Text(
                  "Select Payment Method",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _PaymentTile(
                  icon: Icons.account_balance_wallet,
                  title: "UPI",
                  subtitle: "Google Pay, PhonePe, Paytm",
                  isSelected: true,
                ),
                _PaymentTile(
                  icon: Icons.credit_card,
                  title: "Debit / Credit Card",
                  subtitle: "Visa, MasterCard, RuPay",
                ),
                _PaymentTile(
                  icon: Icons.account_balance,
                  title: "Net Banking",
                  subtitle: "All major banks",
                ),
                _PaymentTile(
                  icon: Icons.money,
                  title: "Cash at Hospital",
                  subtitle: "Pay during visit",
                ),

                const SizedBox(height: 28),

                /// AMOUNT DETAILS
                const Text(
                  "Payment Summary",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                _amountCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _amountCard() {
    final double consultationFee = double.parse(model.docFees); // taxable
    final double gstAmount = consultationFee * 0.18;
    final double totalPayable = consultationFee + gstAmount;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _amountRow(
            "Consultation Fee",
            AppPriceFormatter.indian(consultationFee),
          ),
          const SizedBox(height: 8),
          _amountRow("GST (18%)", AppPriceFormatter.indian(gstAmount)),
          const Divider(height: 24),
          _amountRow(
            "Total Payable",
            AppPriceFormatter.indian(totalPayable),
            isTotal: true,
          ),
        ],
      ),
    );
  }

  double calculateGst(double amount) {
    return amount * 0.18;
  }

  double calculateTotal(double amount) {
    return amount + calculateGst(amount);
  }

  static Widget _amountRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: isTotal ? Colors.black : Colors.grey,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Colors.blue : Colors.black,
          ),
        ),
      ],
    );
  }
}

/// ================= PAYMENT TILE =================

class _PaymentTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;

  const _PaymentTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.transparent,
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}
