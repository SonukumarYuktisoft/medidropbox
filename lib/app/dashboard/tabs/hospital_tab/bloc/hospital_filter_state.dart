import 'package:medidropbox/app/models/hospitals_models/all_hospital_model.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFilterState extends Equatable {
  final String selectedState;
  final String selectedCity;
  final List<String> availableCities;
  final bool emergencyAvailable;
  final bool isActive;
  final bool is24x7;
  final bool hasAmbulance;
  final Map<String, dynamic>? appliedFilters;
  final String pincode;
  final String lat;
  final String lng;
  final String radius;
  final String searchKey;

  

  const HospitalFilterState({
    this.selectedState = '',
    this.selectedCity = '',
    this.availableCities = const [],
    this.emergencyAvailable = false,
    this.isActive = true,
    this.is24x7 = false,
    this.hasAmbulance = false,
    this.appliedFilters,
    this.lat = '',
    this.lng = '',
    this.radius = '',
    this.pincode = '',
    this.allHospitalList,
    this.allHospitalStatus=ApiStatus.initial,
    this.pageStatus=ApiStatus.initial,
    this.mess= '',
    this.searchKey= ''
  });
    final  String mess;
   final ApiStatus allHospitalStatus;
   final List<AllHospitalModel>? allHospitalList;
    final ApiStatus pageStatus;

  HospitalFilterState copyWith({
    String? selectedState,
    String? selectedCity,
    List<String>? availableCities,
    bool? emergencyAvailable,
    bool? isActive,
    bool? is24x7,
    bool? hasAmbulance,
    Map<String, dynamic>? appliedFilters,

    String? pincode,
    String? lat,
    String? lng,
    String? radius,

    String? mess,
    ApiStatus? allHospitalStatus,
    ApiStatus? pageStatus,
    List<AllHospitalModel>? allHospitalList,
     String? searchKey,
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

      pincode: pincode ?? this.pincode,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      radius: radius ?? this.radius,

      mess: mess??this.mess,
      allHospitalStatus: allHospitalStatus??this.allHospitalStatus,
      allHospitalList: allHospitalList??this.allHospitalList,
      pageStatus: pageStatus??this.pageStatus,
      searchKey: searchKey??this.searchKey,



    );
  }

  @override
  List<Object?> get props => [
    pageStatus,
    mess,
    allHospitalList,
    allHospitalStatus,
    radius,
    lat,
    lng,
    pincode,
    selectedState,
    selectedCity,
    availableCities,
    emergencyAvailable,
    isActive,
    is24x7,
    hasAmbulance,
    appliedFilters,
    searchKey
  ];
}
