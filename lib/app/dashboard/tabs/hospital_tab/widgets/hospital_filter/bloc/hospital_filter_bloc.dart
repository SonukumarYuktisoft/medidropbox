import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/bloc/hospital_filter_event.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/bloc/hospital_filter_state.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFilterBloc
    extends Bloc<HospitalFilterEvent, HospitalFilterState> {
  // State-City mapping
  final Map<String, List<String>> stateCityMap = {
    'Andhra Pradesh': [
      'Visakhapatnam',
      'Vijayawada',
      'Guntur',
      'Nellore',
      'Tirupati',
      'Kurnool',
    ],

    'Arunachal Pradesh': ['Itanagar', 'Tawang', 'Naharlagun', 'Pasighat'],

    'Assam': ['Guwahati', 'Silchar', 'Dibrugarh', 'Jorhat', 'Tezpur'],

    'Bihar': [
      'Patna',
      'Gaya',
      'Bhagalpur',
      'Muzaffarpur',
      'Darbhanga',
      'Bagaha',
    ],

    'Chhattisgarh': ['Raipur', 'Bilaspur', 'Durg', 'Bhilai', 'Korba'],

    'Goa': ['Panaji', 'Margao', 'Vasco da Gama', 'Mapusa'],

    'Gujarat': [
      'Ahmedabad',
      'Surat',
      'Vadodara',
      'Rajkot',
      'Bhavnagar',
      'Jamnagar',
    ],

    'Haryana': ['Gurgaon', 'Faridabad', 'Panipat', 'Ambala', 'Hisar'],

    'Himachal Pradesh': ['Shimla', 'Manali', 'Dharamshala', 'Solan', 'Mandi'],

    'Jharkhand': ['Ranchi', 'Jamshedpur', 'Dhanbad', 'Bokaro'],

    'Karnataka': [
      'Bangalore',
      'Mysore',
      'Hubli',
      'Mangalore',
      'Belgaum',
      'Davangere',
    ],

    'Kerala': [
      'Thiruvananthapuram',
      'Kochi',
      'Kozhikode',
      'Thrissur',
      'Kollam',
    ],

    'Madhya Pradesh': ['Bhopal', 'Indore', 'Gwalior', 'Jabalpur', 'Ujjain'],

    'Maharashtra': [
      'Mumbai',
      'Pune',
      'Nagpur',
      'Nashik',
      'Aurangabad',
      'Solapur',
    ],

    'Manipur': ['Imphal', 'Thoubal', 'Churachandpur'],

    'Meghalaya': ['Shillong', 'Tura', 'Nongpoh'],

    'Mizoram': ['Aizawl', 'Lunglei', 'Champhai'],

    'Nagaland': ['Kohima', 'Dimapur', 'Mokokchung'],

    'Odisha': ['Bhubaneswar', 'Cuttack', 'Rourkela', 'Sambalpur', 'Puri'],

    'Punjab': ['Chandigarh', 'Ludhiana', 'Amritsar', 'Jalandhar', 'Patiala'],

    'Rajasthan': ['Jaipur', 'Jodhpur', 'Udaipur', 'Kota', 'Ajmer'],

    'Sikkim': ['Gangtok', 'Namchi', 'Gyalshing'],

    'Tamil Nadu': [
      'Chennai',
      'Coimbatore',
      'Madurai',
      'Tiruchirappalli',
      'Salem',
    ],

    'Telangana': ['Hyderabad', 'Warangal', 'Karimnagar', 'Nizamabad'],

    'Tripura': ['Agartala', 'Udaipur', 'Dharmanagar'],

    'Uttar Pradesh': [
      'Lucknow',
      'Kanpur',
      'Varanasi',
      'Agra',
      'Meerut',
      'Noida',
    ],

    'Uttarakhand': ['Dehradun', 'Haridwar', 'Rishikesh', 'Haldwani'],

    'West Bengal': ['Kolkata', 'Howrah', 'Durgapur', 'Asansol', 'Siliguri'],

    // ---------- UNION TERRITORIES ----------
    'Andaman and Nicobar Islands': ['Port Blair'],

    'Chandigarh': ['Chandigarh'],

    'Dadra and Nagar Haveli and Daman and Diu': ['Daman', 'Silvassa', 'Diu'],

    'Delhi': [
      'New Delhi',
      'North Delhi',
      'South Delhi',
      'East Delhi',
      'West Delhi',
    ],

    'Jammu and Kashmir': ['Srinagar', 'Jammu', 'Anantnag'],

    'Ladakh': ['Leh', 'Kargil'],

    'Lakshadweep': ['Kavaratti'],

    'Puducherry': ['Puducherry', 'Karaikal', 'Mahe', 'Yanam'],
  };

  HospitalFilterBloc() : super(const HospitalFilterState()) {
    on<OnStateChanged>(_onStateChanged);
    on<OnCityChanged>(_onCityChanged);
    on<OnEmergencyToggled>(_onEmergencyToggled);
    on<OnActiveToggled>(_onActiveToggled);
    on<On24x7Toggled>(_on24x7Toggled);
    on<OnAmbulanceToggled>(_onAmbulanceToggled);
    on<OnApplyFilters>(_onApplyFilters);
    on<OnResetFilters>(_onResetFilters);
  }

  void _onStateChanged(
    OnStateChanged event,
    Emitter<HospitalFilterState> emit,
  ) {
    final cities = event.state != null ? (stateCityMap[event.state] ?? []) : [];
    emit(
      state.copyWith(
        selectedState: event.state,
        selectedCity: null, // Reset city when state changes
        availableCities: cities.cast<String>(),
      ),
    );
  }

  void _onCityChanged(OnCityChanged event, Emitter<HospitalFilterState> emit) {
    emit(state.copyWith(selectedCity: event.city));
  }

  void _onEmergencyToggled(
    OnEmergencyToggled event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(emergencyAvailable: event.value));
  }

  void _onActiveToggled(
    OnActiveToggled event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(isActive: event.value));
  }

  void _on24x7Toggled(On24x7Toggled event, Emitter<HospitalFilterState> emit) {
    emit(state.copyWith(is24x7: event.value));
  }

  void _onAmbulanceToggled(
    OnAmbulanceToggled event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(hasAmbulance: event.value));
  }

  void _onApplyFilters(
    OnApplyFilters event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(appliedFilters: event.filters));
  }

  void _onResetFilters(
    OnResetFilters event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(const HospitalFilterState());
  }
}
