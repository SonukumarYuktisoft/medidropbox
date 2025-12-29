import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/models/hospitals_models/all_hospital_model.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/horizental_list_shimmer.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) => previous.allHospitalStatus!=current.allHospitalStatus,
      builder: (context, state) {
        if(state.allHospitalStatus==ApiStatus.loading){
          return HorizentalListShimmer(height: 200,width: 262,horizontalMargin: 15,);
        }
        if(state.allHospitalStatus==ApiStatus.error){
          return RefreshView(onPressed: () => 
          context.read<HomeBloc>().add(OnGetAllHospital())).radiusContainer(
            color: Colors.grey.shade300,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 40),
          );
        }
         if(state.allHospitalStatus==ApiStatus.success){
          if(state.allHospitalList==null||state.allHospitalList!.isEmpty){
            return DataNotFound();
          }
          return SizedBox(
          height: 310,
          child: ListView.separated(
            itemCount: state.allHospitalList!.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            separatorBuilder: (context, index) => SizedBox(width: 15,),
            itemBuilder: (context, index) {
              var data = state.allHospitalList![index];
              return _card(data);
            },
          ),
        );
        }
      return SizedBox();
      },
    );
  }

  Widget _card(AllHospitalModel data) {
  return Container(
    width: 220,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// IMAGE WITH EMERGENCY BADGE
        Stack(
          children: [
            data.images!.first.toTopRadiusImage(
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              radius: 18,
            ),
            // Emergency Badge (if available)
            if (data.emergencyAvailable == true)
              Positioned(
                top: 10,
                right: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_hospital, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    "Emergency".toHeadingText(
                      fontSize: 11,
                      color: Colors.white,
                      appFontStyle: AppFontStyle.semiBold,
                    ),
                  ],
                ).radiusContainerWithShadow(
                  radius: 15,
                  color: Colors.red,
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                ),
              ),
          ],
        ),

        const SizedBox(height: 12),

        /// HOSPITAL NAME
        data.name.toString().toLimitLineText(
          maxLines: 1,
          fontSize: 15,
          appFontStyle: AppFontStyle.bold,
        ).paddingHorizontal(12),

        const SizedBox(height: 6),

        /// LOCATION
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 14,
              color: Colors.red.shade400,
              shadows: toIconShadow(),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: "${data.address!.city}, ${data.address!.state}".toLimitLineText(
                maxLines: 1,
                appFontStyle: AppFontStyle.regular,
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ).paddingHorizontal(12),

        const SizedBox(height: 8),

        /// SERVICES COUNT (Optional)
        if (data.services != null && data.services!.isNotEmpty)
          Row(
            children: [
              Icon(Icons.medical_services_outlined, size: 14, color: Colors.blue.shade600),
              const SizedBox(width: 4),
              "${data.services!.length} Services Available".toHeadingText(
                fontSize: 11,
                color: Colors.grey.shade600,
                appFontStyle: AppFontStyle.regular,
              ),
            ],
          ).paddingHorizontal(12),

        const SizedBox(height: 10),

        /// FACILITIES CHIPS
        if (data.facilities != null && data.facilities!.isNotEmpty)
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: data.facilities!.take(3).map((facility) {
                return Container(
                  margin: EdgeInsets.only(
                    right: facility == data.facilities!.take(3).last ? 0 : 8,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade100),
                  ),
                  child: facility.toHeadingText(
                    fontSize: 10,
                    color: Colors.blue.shade700,
                    appFontStyle: AppFontStyle.medium,
                  ),
                );
              }).toList(),
            ),
          ),

        const SizedBox(height: 12),

        /// FOUNDED YEAR (Optional Footer)
        if (data.foundedOn != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 11, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    "Since ${DateTime.parse(data.foundedOn.toString()).year}".toHeadingText(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                      appFontStyle: AppFontStyle.regular,
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade400),
              ],
            ),
          ),
      ],
    ),
  ).asButton(
    onTap: () {
      AppNavigators.pushNamed(AppRoutesName.hospitalDetailsView,extra: data.id.toString() );
    },
  );
}
}
