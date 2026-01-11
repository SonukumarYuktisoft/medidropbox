part of 'health_profile_bloc.dart';

abstract class HealthProfileEvent extends Equatable {
  const HealthProfileEvent();

  @override
  List<Object> get props => [];
}

class OnGetHealthProfile extends HealthProfileEvent{}

class OnBMIReportApi extends HealthProfileEvent{}
class OnGetLatestVitalApi extends HealthProfileEvent{}


class OnGetVitalHistoryApi extends HealthProfileEvent{}

class OnCreateVitalsEvent extends HealthProfileEvent {
  final double weightKg;
  final double bloodGlucoseMgdl;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final String recordedAt;
  final String notes;

  const OnCreateVitalsEvent({
    required this.weightKg,
    required this.bloodGlucoseMgdl,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.recordedAt,
    required this.notes,
  });

  @override
  List<Object> get props => [
        weightKg,
        bloodGlucoseMgdl,
        bloodPressureSystolic,
        bloodPressureDiastolic,
        recordedAt,
        notes,
      ];
}


class OnEditVitalsEvent extends HealthProfileEvent {
  final double weightKg;
  final double bloodGlucoseMgdl;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final String notes;
  final String id;

  const OnEditVitalsEvent({
    required this.weightKg,
    required this.bloodGlucoseMgdl,
    required this.bloodPressureSystolic,
    required this.bloodPressureDiastolic,
    required this.notes,
    required this.id,
  });

  @override
  List<Object> get props => [
        weightKg,
        bloodGlucoseMgdl,
        bloodPressureSystolic,
        bloodPressureDiastolic,
        notes,
        id
      ];
}



class OnUpdateHealthProfileEvent extends HealthProfileEvent {
  final double heightCm;
  final String bloodGroup;
  final String gender;
  final String dateOfBirth;

  const OnUpdateHealthProfileEvent({
    required this.heightCm,
    required this.bloodGroup,
    required this.gender,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props => [
        heightCm,
        bloodGroup,
        gender,
        dateOfBirth,
      ];
}
