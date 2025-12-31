part of 'doctor_tab_bloc.dart';

abstract class DoctorTabEvent extends Equatable {
  const DoctorTabEvent();
  @override
  List<Object> get props => [];
}


class OnChangedSpecialty extends DoctorTabEvent {
  final String specialty;
  const OnChangedSpecialty(this.specialty);
  @override
  List<Object> get props => [specialty];
}

class OnChangedMinRating extends DoctorTabEvent {
  final String minRating;
  const OnChangedMinRating(this.minRating);
  @override
  List<Object> get props => [minRating];
}

class OnChangedMaxRating extends DoctorTabEvent {
  final String maxRating;
  const OnChangedMaxRating(this.maxRating);
  @override
  List<Object> get props => [maxRating];
}

class OnChangedIsActive extends DoctorTabEvent {
  final bool isActive;
  const OnChangedIsActive(this.isActive);
  @override
  List<Object> get props => [isActive];
}

class OnChangedMinFess extends DoctorTabEvent {
  final String minFees;
  const OnChangedMinFess(this.minFees);
  @override
  List<Object> get props => [minFees];
}

class OnChangedMaxFess extends DoctorTabEvent {
  final String maxFees;
  const OnChangedMaxFess(this.maxFees);
  @override
  List<Object> get props => [maxFees];
}

class OnChangedAllowRemote extends DoctorTabEvent {
  final String allowRemote;
  const OnChangedAllowRemote(this.allowRemote);
  @override
  List<Object> get props => [allowRemote];
}

class OnChangedSearch extends DoctorTabEvent {
  final String search;
  const OnChangedSearch(this.search);
  @override
  List<Object> get props => [search];
}




class OnApplyFilters extends DoctorTabEvent {}
class OnGetAllDoctors extends DoctorTabEvent {}
class OnPageNation extends DoctorTabEvent {}
class OnRefressh extends DoctorTabEvent {}
