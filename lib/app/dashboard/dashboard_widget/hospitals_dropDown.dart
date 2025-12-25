import 'dart:developer';

import 'package:medidropbox/app/dashboard/bloc/dashboard_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/models/hospitals/all_hospital_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalsDropdown extends StatelessWidget {
  const HospitalsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return DropdownButtonFormField<AllHospitalModel>(
          items: state.allHospitalList!.map((hospital) {
            return DropdownMenuItem<AllHospitalModel>(
              value: hospital,
              child: Text(hospital.name.toString()),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) return;
            log(value.id.toString(), name: "ID MIL GAYA YOOHU");
            context.read<HomeBloc>().add(OnSelecteHospitalData(value));
          },
        );
      },
    );
  }
}
