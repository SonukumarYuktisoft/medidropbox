import 'package:medidropbox/app/dashboard/tabs/doctor_tab/bloc/doctor_tab_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_card.dart';
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_search_and_filtter_btn.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/doctor_shimmer/doctor_cards_shimmer/doctor_grid_card_shimmer.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class DoctorTab extends StatefulWidget {
  const DoctorTab({super.key});

  @override
  State<DoctorTab> createState() => _DoctorTabState();
}

class _DoctorTabState extends State<DoctorTab> {

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<DoctorTabBloc>().add(OnRefressh());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.heightBox,
       DoctorSearchAndFiltterBtn(),
          
        Expanded(
          child: BlocBuilder<DoctorTabBloc, DoctorTabState>(
            buildWhen: (previous, current) =>
                previous.doctorStatus != current.doctorStatus,

            builder: (context, state) {
              if (state.doctorStatus == ApiStatus.loading) {
                 return DoctorGridCardShimmer();
             
              } else if (state.doctorStatus == ApiStatus.error) {
                return RefreshView(
                  onPressed: () =>
                      context.read<DoctorTabBloc>().add(OnRefressh()),
                ).radiusContainer(
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 40),
                );
              } else if (state.doctorStatus == ApiStatus.success) {
               if(state.doctorList==null||state.doctorList!.isEmpty){
                return RefreshView(
                  onPressed: () =>
                      context.read<DoctorTabBloc>().add(OnRefressh()),
                ).radiusContainer(
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 40),
                );
               }

                return GridView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.75,
                            ),
                        // itemCount: doctors.length,
                        itemCount: state.doctorList?.length ?? 0,

                        itemBuilder: (context, index) {
                          final d = state.doctorList![index];
                          return DoctorCard(doctor: d);
                        },
                      );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }

}
