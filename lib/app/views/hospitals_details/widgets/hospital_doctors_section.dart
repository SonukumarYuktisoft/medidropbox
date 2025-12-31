import 'package:medidropbox/app/models/doctors_models/all_doctors_model.dart';
import 'package:medidropbox/app/views/hospitals_details/bloc/hospital_detail_bloc.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_%20detail_shimmer/hospital_doctors_detail_section_shimmer.dart';
import 'package:medidropbox/core/utility/const/price_formate.dart';

class HospitalDoctorsSection extends StatelessWidget {
  const HospitalDoctorsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HospitalDetailBloc, HospitalDetailState>(
      buildWhen: (previous, current) => previous.allDoctorStatus!=current.allDoctorStatus
      ||previous.selectedDoctor!=current.selectedDoctor,
      builder: (context, state) {
        if (state.allDoctorStatus == ApiStatus.loading) {
          return HospitalDoctorsDetailSectionShimmer();
        } else if (state.allDoctorStatus == ApiStatus.error) {
          return Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.error_outline, color: Colors.grey),
                  8.heightBox,
                  const Text('Error loading doctors'),
                ],
              ),
            ),
          );
        } else if (state.allDoctorStatus == ApiStatus.success &&
            state.allDoctorList != null &&
            state.allDoctorList!.isNotEmpty) {
          final doctors = state.allDoctorList!;

          return Container(
            color: Colors.white, // Background color for the section
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Our Doctors".toHeadingText(
                  fontSize: 18,
                  appFontStyle: AppFontStyle.semiBold,
                ),
                12.heightBox,
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final doctor = doctors[index];
                      final bool isSelected = state.selectedDoctor!.id.toString()==doctor.id.toString();
                      return _doc(context, doctor,isSelected);
                    },
                    separatorBuilder: (context, index) => 12.widthBox,
                    itemCount: doctors.length,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _doc(BuildContext context,AllDoctorsModel doctor,bool isSelected){
    return Stack(
      children: [
        Column(
          children: [
            Center(child: doctor.profilePhotoUrl.toCircularImage(size: 70)),
            SizedBox(height: 10),
            Text(
              doctor.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
             Text(
              doctor.specialty,
              style: TextStyle(fontSize: 12),
            ),
            3.heightBox,
             Row(
               children: [
                 Text(
                  "Fees: ",
                  style: TextStyle(fontSize: 14,color: Colors.green,fontWeight: FontWeight.bold),
                             ),
                 Text(
                  AppPriceFormatter.indian(doctor.fees),
            
                  style: TextStyle(fontSize: 17),
                             ),
               ],
             ),

          ],
        ).radiusContainerWithShadow(
          padding: EdgeInsets.all(10),
          color: Colors.white
            ),
          if(isSelected)
          Positioned(
            top: 5.0,right: 5.0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.done,color: Colors.white,size: 15,)),
          )


      ],
    ).asButton(onTap: (){
      context.read<HospitalDetailBloc>().add(OnSelectDoctor(doctor));
    });
  }
}