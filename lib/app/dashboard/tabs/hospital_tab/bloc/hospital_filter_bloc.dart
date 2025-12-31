import 'dart:developer';

import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_event.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_state.dart';
import 'package:medidropbox/app/models/hospitals_models/all_hospital_model.dart';
import 'package:medidropbox/app/repository/hospitals/hospital_repo.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFilterBloc
    extends Bloc<HospitalFilterEvent, HospitalFilterState> {
  // State-City mapping
  HospitalRepo repo;
  HospitalFilterBloc(this.repo) : super(const HospitalFilterState()) {
    on<OnStateChanged>(_onStateChanged);
    on<OnCityChanged>(_onCityChanged);
    on<OnEmergencyToggled>(_onEmergencyToggled);
    on<OnActiveToggled>(_onActiveToggled);
    on<On24x7Toggled>(_on24x7Toggled);
    on<OnAmbulanceToggled>(_onAmbulanceToggled);
    on<OnApplyFilters>(_onApplyFilters);

    on<OnChangedPinCode>(_onChangedPinCode);
    on<OnChangedLat>(_onChangedLat);
    on<OnChangedLng>(_onChangedLng);
    on<OnChangedSearch>(_onChangedSearch);
    on<OnChangedRadius>(_onChangedRadius);
    on<OnGetAllHospital>(_onGetAllHospital);
        on<OnPageNation>(_onPageNation);
        on<OnRefressh>(_onRefresh);

  }

  int page = 0;
  List<AllHospitalModel> hospitals = [];

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
    emit(state.copyWith(allHospitalStatus: ApiStatus.loading));
    hospitals.clear();
    page=0;
    add(OnGetAllHospital());
  }



 

  void _onChangedLat(OnChangedLat event, Emitter<HospitalFilterState> emit) {
    emit(state.copyWith(lat: event.lat));
  }

  void _onChangedLng(OnChangedLng event, Emitter<HospitalFilterState> emit) {
    emit(state.copyWith(lng: event.lng));
  }

  void _onChangedPinCode(
    OnChangedPinCode event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(pincode: event.pincode));
  }

  void _onChangedRadius(
    OnChangedRadius event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(radius: event.radius));
  }


List<AllHospitalModel> allHospitalModelListFromJson(dynamic data) {
  log(data.toString(),name: "dfknjsdkjfksjdfsdfsdfsdfsdfsdf---");
    // Check if data has pagination wrapper (content field)
    if (data is Map<String, dynamic> && data.containsKey('content')) {
      final response = AllHospitalResponse.fromJson(data);
      return response.content ?? [];
    }
    // Fallback to direct list parsing
    else if (data is List) {
      return data
          .map((e) => AllHospitalModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }


  void _onChangedSearch(
    OnChangedSearch event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(searchKey: event.searchKey));
    add(OnApplyFilters());
  }

  void _onGetAllHospital(
    OnGetAllHospital event,
    Emitter<HospitalFilterState> emit,
  ) async {
    Map<String, dynamic> data = {
      "state": state.selectedState,
      "city": state.selectedCity,
      "emergencyAvailable": (!state.emergencyAvailable)?null:true,
      "isActive":(!state.isActive)?null:true,
      "is24x7": (!state.is24x7)?null:true,
      "hasAmbulance":  (!state.hasAmbulance)?null:true,
      "pincode": state.pincode ,
      "radius": state.radius,
      "longitude": state.lng,
      "latitude": state.lat,
      "search": state.searchKey,
    };

    try {
      final res = await repo.getAllHospitals(
        page: page,
        size: 10,
        filters: data,
      );

      ApiResponseHandler.handle<List<AllHospitalModel>, HospitalFilterState>(
        emit: emit,
        state: state,
        response: res,
        parser: (d) =>allHospitalModelListFromJson(d),
        onSuccess: (state, mess, data) {
          // Check if we should have more data
          hospitals.addAll(data);

          return state.copyWith(
            mess: mess,
            allHospitalList: hospitals,
            allHospitalStatus: ApiStatus.success,
            pageStatus: ApiStatus.success,
          );
        },
        onError: (state, mess) => state.copyWith(
          allHospitalStatus: ApiStatus.success,
          pageStatus: ApiStatus.error,
          mess: mess,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          mess: e.toString(),
          allHospitalStatus: ApiStatus.error,
          pageStatus: ApiStatus.error,
        ),
      );
    }
  }

  void _onPageNation(
    OnPageNation event,
    Emitter<HospitalFilterState> emit,
  ) {
    emit(state.copyWith(pageStatus: ApiStatus.loading));
    page+=1;
    add(OnGetAllHospital());
  }
  void _onRefresh(OnRefressh event, Emitter<HospitalFilterState> emit) {
    emit(state.copyWith(allHospitalStatus: ApiStatus.loading,
    radius: "",
    selectedState: "",searchKey: "",selectedCity: "",
   lat: "",lng: "",
   is24x7: false,
   emergencyAvailable: false,
   isActive: false,
   hasAmbulance: false,
    
    ));
    hospitals.clear();
    page=0;
    add(OnGetAllHospital());
  }
}

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

  'Bihar': ['Patna', 'Gaya', 'Bhagalpur', 'Muzaffarpur', 'Darbhanga', 'Bagaha'],

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

  'Kerala': ['Thiruvananthapuram', 'Kochi', 'Kozhikode', 'Thrissur', 'Kollam'],

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

  'Uttar Pradesh': ['Lucknow', 'Kanpur', 'Varanasi', 'Agra', 'Meerut', 'Noida'],

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
