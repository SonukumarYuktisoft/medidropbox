part of 'hospital_bloc.dart';

 class HospitalState extends Equatable {
  const HospitalState({this.showMoreDetails = false});
  final bool showMoreDetails;

  HospitalState copyWith({bool? showMoreDetails}) {
    return HospitalState(
      showMoreDetails: showMoreDetails ?? this.showMoreDetails,
    );
  }

  @override
  List<Object?> get props => [showMoreDetails];
}
