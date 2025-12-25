import 'package:flutter/material.dart';
import 'package:medidropbox/app/dashboard/tabs/appointment/bloc/appointment_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class BookingDetails extends StatefulWidget {
  final String bookingId;
  const BookingDetails(this.bookingId, {super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AppointmentBloc>().add(OnGetBookingByid(widget.bookingId));
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
