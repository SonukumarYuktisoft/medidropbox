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
  final Map<String, dynamic> filters;

  const OnApplyFilters(this.filters);

  @override
  List<Object> get props => [filters];
}

class OnResetFilters extends HospitalFilterEvent {
  const OnResetFilters();
}