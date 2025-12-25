import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAppointmentPage extends StatefulWidget {
  const CreateAppointmentPage({super.key});

  @override
  State<CreateAppointmentPage> createState() => _CreateAppointmentPageState();
}

class _CreateAppointmentPageState extends State<CreateAppointmentPage> {
  final _formKey = GlobalKey<FormState>();

  // IDs
  final doctorIdCtrl = TextEditingController();
  final hospitalIdCtrl = TextEditingController();

  // Date & Time
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final dateCtrl = TextEditingController();
  final timeCtrl = TextEditingController();

  // Consent
  bool dataConsent = false;

  // Payment
  final paymentModeCtrl = TextEditingController();
  final totalBillCtrl = TextEditingController();
  final totalAmountCtrl = TextEditingController();
  final discountCtrl = TextEditingController();
  final taxableAmountCtrl = TextEditingController();
  final gstCtrl = TextEditingController();
  final transactionIdCtrl = TextEditingController();

  @override
  void dispose() {
    doctorIdCtrl.dispose();
    hospitalIdCtrl.dispose();
    dateCtrl.dispose();
    timeCtrl.dispose();
    paymentModeCtrl.dispose();
    totalBillCtrl.dispose();
    totalAmountCtrl.dispose();
    discountCtrl.dispose();
    taxableAmountCtrl.dispose();
    gstCtrl.dispose();
    transactionIdCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      selectedDate = picked;
      dateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      selectedTime = picked;
      timeCtrl.text =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}:00";
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "doctorId": int.parse(doctorIdCtrl.text),
      "hospitalId": int.parse(hospitalIdCtrl.text),
      "bookingDate": dateCtrl.text,
      "bookingTime": timeCtrl.text,
      "dataConsent": dataConsent,
      "payment": {
        "paymentMode": paymentModeCtrl.text,
        "totalBill": double.parse(totalBillCtrl.text),
        "totalAmount": double.parse(totalAmountCtrl.text),
        "discount": double.parse(discountCtrl.text),
        "taxableAmount": double.parse(taxableAmountCtrl.text),
        "gst": double.parse(gstCtrl.text),
        "transactionId": transactionIdCtrl.text,
      },
    };

    debugPrint("CREATE APPOINTMENT PAYLOAD:");
    debugPrint(payload.toString());

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Create Appointment",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,

        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("Doctor ID"),
              _field(doctorIdCtrl, "Enter doctor id"),

              _label("Hospital ID"),
              _field(hospitalIdCtrl, "Enter hospital id"),

              _label("Booking Date"),
              _pickerField(dateCtrl, "Select date", _pickDate),

              _label("Booking Time"),
              _pickerField(timeCtrl, "Select time", _pickTime),

              const SizedBox(height: 16),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("I agree to data consent"),
                value: dataConsent,
                onChanged: (v) => setState(() => dataConsent = v ?? false),
              ),

              const Divider(height: 32),

              _label("Payment Mode"),
              _field(paymentModeCtrl, "UPI / CARD / CASH"),

              _label("Total Bill"),
              _numberField(totalBillCtrl),

              _label("Total Amount"),
              _numberField(totalAmountCtrl),

              _label("Discount"),
              _numberField(discountCtrl),

              _label("Taxable Amount"),
              _numberField(taxableAmountCtrl),

              _label("GST"),
              _numberField(gstCtrl),

              _label("Transaction ID"),
              _field(transactionIdCtrl, "Transaction id"),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Create Appointment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _field(TextEditingController c, String hint) {
    return TextFormField(
      controller: c,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
      decoration: _decoration(hint),
    );
  }

  Widget _numberField(TextEditingController c) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.number,
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
      decoration: _decoration("0.00"),
    );
  }

  Widget _pickerField(
    TextEditingController c,
    String hint,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          controller: c,
          validator: (v) => v == null || v.isEmpty ? "Required" : null,
          decoration: _decoration(hint),
        ),
      ),
    );
  }

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xffF5F5F5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
