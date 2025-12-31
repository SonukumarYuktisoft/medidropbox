import 'package:equatable/equatable.dart';

// ==================== EVENTS ====================
abstract class HospitalFilterEvent extends Equatable {
  const HospitalFilterEvent();

  @override
  List<Object?> get props => [];
}

class OnStateChanged extends HospitalFilterEvent {
  final String? state;

  const OnStateChanged(this.state);

  @override
  List<Object?> get props => [state];
}

class OnCityChanged extends HospitalFilterEvent {
  final String? city;

  const OnCityChanged(this.city);

  @override
  List<Object?> get props => [city];
}

class OnEmergencyToggled extends HospitalFilterEvent {
  final bool value;

  const OnEmergencyToggled(this.value);

  @override
  List<Object> get props => [value];
}

class OnActiveToggled extends HospitalFilterEvent {
  final bool value;

  const OnActiveToggled(this.value);

  @override
  List<Object> get props => [value];
}

class On24x7Toggled extends HospitalFilterEvent {
  final bool value;

  const On24x7Toggled(this.value);

  @override
  List<Object> get props => [value];
}

class OnAmbulanceToggled extends HospitalFilterEvent {
  final bool value;

  const OnAmbulanceToggled(this.value);

  @override
  List<Object> get props => [value];
}

class OnApplyFilters extends HospitalFilterEvent {
}





class OnChangedPinCode extends HospitalFilterEvent {
  const OnChangedPinCode(this.pincode);
final String pincode;
  @override
  List<Object> get props => [pincode];
}
class OnChangedLat extends HospitalFilterEvent {
  const OnChangedLat(this.lat);
final String lat;
  @override
  List<Object> get props => [lat];
}
class OnChangedLng extends HospitalFilterEvent {
  const OnChangedLng(this.lng);
final String lng;
  @override
  List<Object> get props => [lng];
}

class OnChangedRadius extends HospitalFilterEvent {
  const OnChangedRadius(this.radius);
final String radius;
  @override
  List<Object> get props => [radius];
}


class OnGetAllHospital extends HospitalFilterEvent {

}

class OnChangedSearch extends HospitalFilterEvent {
  const OnChangedSearch(this.searchKey);
final String searchKey;
  @override
  List<Object> get props => [searchKey];
}


class OnPageNation extends HospitalFilterEvent {

}
class OnRefressh extends HospitalFilterEvent {

}