import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_card.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/doctor_shimmer/doctor_cards_shimmer/doctor_grid_card_shimmer.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class DoctorTab extends StatefulWidget {
  const DoctorTab({super.key});

  @override
  State<DoctorTab> createState() => _DoctorTabState();
}

class _DoctorTabState extends State<DoctorTab> {
  @override
  void initState() {
    context.read<HomeBloc>().add(OnGetAllDoctors('1'));
    // context.read<HomeBloc>().add(OnGetAllHospital());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),

        Expanded(
          child: BlocBuilder<HomeBloc, HomeState>(
            buildWhen: (previous, current) =>
                previous.allDoctorStatus != current.allDoctorStatus,

            builder: (context, state) {
              if (state.allDoctorStatus == ApiStatus.error) {
                return RefreshView(
                  onPressed: () =>
                      context.read<HomeBloc>().add(OnGetAllDoctors('1')),
                ).radiusContainer(
                  color: Colors.grey.shade300,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(vertical: 40),
                );
              } else if (state.allDoctorStatus == ApiStatus.loading) {
                return DoctorGridCardShimmer();
              } else if (state.allDoctorStatus == ApiStatus.success) {
                return Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
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
                        itemCount: state.allDoctorList?.length ?? 0,

                        itemBuilder: (context, index) {
                          final d = state.allDoctorList![index];
                          return DoctorCard(doctor: d);
                        },
                      ),
                    ),
                  ],
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
