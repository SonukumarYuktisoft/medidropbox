import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFilterState extends Equatable {
  final String? selectedState;
  final String? selectedCity;
  final List<String> availableCities;
  final bool emergencyAvailable;
  final bool isActive;
  final bool is24x7;
  final bool hasAmbulance;
  final Map<String, dynamic>? appliedFilters;

  const HospitalFilterState({
    this.selectedState,
    this.selectedCity,
    this.availableCities = const [],
    this.emergencyAvailable = false,
    this.isActive = true,
    this.is24x7 = false,
    this.hasAmbulance = false,
    this.appliedFilters,
  });

  HospitalFilterState copyWith({
    String? selectedState,
    String? selectedCity,
    List<String>? availableCities,
    bool? emergencyAvailable,
    bool? isActive,
    bool? is24x7,
    bool? hasAmbulance,
    Map<String, dynamic>? appliedFilters,
  }) {
    return HospitalFilterState(
      selectedState: selectedState ?? this.selectedState,
      selectedCity: selectedCity ?? this.selectedCity,
      availableCities: availableCities ?? this.availableCities,
      emergencyAvailable: emergencyAvailable ?? this.emergencyAvailable,
      isActive: isActive ?? this.isActive,
      is24x7: is24x7 ?? this.is24x7,
      hasAmbulance: hasAmbulance ?? this.hasAmbulance,
      appliedFilters: appliedFilters ?? this.appliedFilters,
    );
  }

  @override
  List<Object?> get props => [
        selectedState,
        selectedCity,
        availableCities,
        emergencyAvailable,
        isActive,
        is24x7,
        hasAmbulance,
        appliedFilters,
      ];
}
