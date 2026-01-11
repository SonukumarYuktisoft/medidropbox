import 'package:medidropbox/app/dashboard/tabs/reports/dialog/create_vital_dialog.dart';
import 'package:medidropbox/app/dashboard/tabs/reports/report_tabs/health_report/vital_history_card.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/app/views/health_profile/health_widget/health_profile_card.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/vertical_grid_shimmer.dart';

class HealthReportMainView extends StatelessWidget {
  const HealthReportMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton(
          tooltip: 'Add Vital',
           child: Icon(Icons.add,shadows: toIconShadow()),
          onPressed: (){showCreateVitalsDialog(context);}),
      body: RefreshIndicator(
        onRefresh: ()async {
      context.read<HealthProfileBloc>().add(OnBMIReportApi());
      context.read<HealthProfileBloc>().add(OnGetLatestVitalApi());
      context.read<HealthProfileBloc>().add(OnGetVitalHistoryApi());
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
            HealthProfileCard(),
            Align(
              alignment: Alignment.centerLeft,
              child: "Vitals History".toHeadingText(
                fontSize: 16,fontWeight: FontWeight.w500
              ).paddingOnly(top: 17,left: 16),
            ),
            VitalHistoryList()
            ],
          ),
        ),
      ),
    );
  }

}


class VitalHistoryList extends StatelessWidget {
  const VitalHistoryList({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthProfileBloc, HealthProfileState>(
      buildWhen: (previous, current) =>
          previous.getVitalHistoryStatus != current.getVitalHistoryStatus,
      builder: (context, state) {
        if (state.getVitalHistoryStatus == ApiStatus.loading) {
          return VerticalGridShimmer(shrinkWrap: true);
        }
        if (state.getVitalHistoryStatus == ApiStatus.error) {
          return RefreshView(
            margin: EdgeInsets.only(top: 70),
            
            onPressed:(){
         
              context.read<HealthProfileBloc>().add(
                OnGetVitalHistoryApi());
            });
        }
        if (state.getVitalHistoryStatus == ApiStatus.success) {
          final data = state.getVitalHistory;
          if (data == null||data.isEmpty) return const DataNotFound(showIcon: true, topPadding: 100,);

          return ListView.builder(
            padding: EdgeInsets.all(15),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return VitalHistoryCard(vitalHistory: data[index]);
            },
          );

        }
        return SizedBox();
      },
    );
  }
}


