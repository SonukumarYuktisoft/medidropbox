import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
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
      buildWhen: (previous, current) => previous.allHospitalSatatus!=current.allHospitalSatatus,
      builder: (context, state) {
        if(state.allHospitalSatatus==ApiStatus.loading){
          return HorizentalListShimmer(height: 200,width: 262,horizontalMargin: 15,);
        }
        if(state.allHospitalSatatus==ApiStatus.error){
          return RefreshView(onPressed: () => 
          context.read<HomeBloc>().add(OnGetAllHospital())).radiusContainer(
            color: Colors.grey.shade300,
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 40),
          );
        }
         if(state.allHospitalSatatus==ApiStatus.success){
          if(state.allHospitalList==null||state.allHospitalList!.isEmpty){
            return DataNotFound();
          }
          return SizedBox(
          height: 260,
          child: ListView.separated(
            itemCount: state.allHospitalList!.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
            separatorBuilder: (context, index) => SizedBox(width: 15,),
            itemBuilder: (context, index) {
              var data = state.allHospitalList![index];
              return _card(image: data.images!.first, name: data.name.toString(),
               location: "${data.address!.state}, ${data.address!.country},", 
               rating: 1,
                category: data.services!.first, fee: '0');
            },
          ),
        );
        }
      return SizedBox();
      },
    );
  }
/* _card(
                image:
                    "https://images.unsplash.com/photo-1586773860418-d37222d8fce3",
                name: "Woodland Hospital",
                location: "New Delhi, India",
                rating: 4.5,
                category: "Hospital",
                fee: "₹500 / visit",
              ), */
  Widget _card({
    required String image,
    required String name,
    required String location,
    required double rating,
    required String category,
    required String fee,
  }) {
    return Container(
      width: 220,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE
          Stack(
            children: [
              image.toTopRadiusImage(
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                radius: 18,
              ),

              /// Favourite icon
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// CATEGORY + RATING
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// HOSPITAL NAME
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                /// LOCATION
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// FEES
                Text(
                  fee,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).asButton(
      onTap: () {
        AppNavigators.pushNamed(AppRoutesName.hospitalDetailsView);
      },
    );
  }
}
