import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_doctors_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_expandable_section_wrapper.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_top_section.dart';
import 'package:medidropbox/core/common/book_appointment_btn.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalDetailsView extends StatefulWidget {
  final String hospitalId;

  const HospitalDetailsView({super.key, required this.hospitalId});

  @override
  State<HospitalDetailsView> createState() => _HospitalDetailsViewState();
}

class _HospitalDetailsViewState extends State<HospitalDetailsView> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<HomeBloc>().add(OnGetHospitalById(widget.hospitalId));
    context.read<HomeBloc>().add(OnGetAllDoctors(widget.hospitalId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xffF4F6FA),

        /// BOOKING BUTTON - Always visible
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            // Show booking button only when both are loaded
            if (state.hospitalDetailStatus == ApiStatus.success) {
              return BookAppointmentBtn();
              // return BookAppointmentBtnSubtle();
            }
            return const SizedBox.shrink();
          },
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              /// SECTION 1: TOP SECTION
              /// Checks only: hospitalDetailStatus
              const HospitalTopSection(),

              /// SECTION 2: DOCTORS SECTION
              /// Checks only: allDoctorStatus
              const HospitalDoctorsSection(),

              /// SECTION 3: EXPANDABLE DETAILS
              /// Checks only: hospitalDetailStatus (for expandable content)
              const HospitalExpandableSectionWrapper(),
            ],
          ),
        ),
      ),
    );
  }
}
