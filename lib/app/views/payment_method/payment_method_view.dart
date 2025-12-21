import 'package:flutter/material.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class PaymentMethodView extends StatelessWidget {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),

      /// PAY BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onPressed: () {
            AppNavigators.pushNamed(AppRoutesName.bookingConfirmView);
          },
          child: const Text(
            "Pay ₹600",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      body: SafeArea(
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
    );
  }

  /// ================= AMOUNT CARD =================
  Widget _amountCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children:  [
          _amountRow("Consultation Fee", "₹600"),
          SizedBox(height: 8),
          _amountRow("Service Charges", "₹0"),
          Divider(height: 24),
          _amountRow(
            "Total Payable",
            "₹600",
            isTotal: true,
          ),
        ],
      ),
    );
  }

  static Widget _amountRow(
    String title,
    String value, {
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: isTotal ? Colors.black : Colors.grey,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight:
                isTotal ? FontWeight.bold : FontWeight.w600,
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
            backgroundColor:
                Colors.blue.withOpacity(0.1),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}
