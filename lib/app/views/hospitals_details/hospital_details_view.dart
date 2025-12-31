import 'package:medidropbox/app/models/common_model/book_appointment_model.dart';
import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_detail_bloc.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_doctors_section.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_expandable_section_wrapper.dart';
import 'package:medidropbox/app/views/hospitals_details/widgets/hospital_top_section.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/common/book_appointment_btn.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
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
    context.read<HospitalDetailBloc>().add(OnGetHospitalById(widget.hospitalId));
   context.read<HospitalDetailBloc>().add(OnGetAllDoctorsByHospital(widget.hospitalId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FA),
      /// BOOKING BUTTON - Always visible
      bottomNavigationBar: BlocBuilder<HospitalDetailBloc, HospitalDetailState>(
        buildWhen: (previous, current) => previous.allDoctorStatus!=current.allDoctorStatus,
        builder: (context, state) {
          // Show booking button only when both are loaded
          if (state.allDoctorStatus == ApiStatus.success&&state.allDoctorList!=null&&state.allDoctorList!.isNotEmpty) {
            return "Book Appointment".toHeadingText(
              color: Colors.white
            ).asElevatedButton(
              onPressed: (){
                if(state.hospitalDetail==null){
                  return AppSnackbar.showError("Hospital Not Available Please try after some time");
                }
              
             AppNavigators.pushNamed(AppRoutesName.paymentMethodView,
             extra: BookAppointmentModel(docId: state.selectedDoctor!.id.toString(),
             hosId: state.hospitalDetail!.id.toString(),
             docFees:state.selectedDoctor!.fees.toString() ).toJson());
            }).paddingAll(15);
         

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
    );
  }
}
