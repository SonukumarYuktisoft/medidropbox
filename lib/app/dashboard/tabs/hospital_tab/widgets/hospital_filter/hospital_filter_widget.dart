import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/bloc/hospital_filter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/bloc/hospital_filter_event.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/bloc/hospital_filter_state.dart';
import 'package:medidropbox/core/common/CommonDropdown.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class HospitalFilterWidget extends StatefulWidget {
  const HospitalFilterWidget({super.key});

  @override
  State<HospitalFilterWidget> createState() => _HospitalFilterWidgetState();
}

class _HospitalFilterWidgetState extends State<HospitalFilterWidget> {
  // Controllers
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();

  @override
  void dispose() {
    pincodeController.dispose();
    searchController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    radiusController.dispose();
    super.dispose();
  }

  void _applyFilters(BuildContext context) {
    final filterState = context.read<HospitalFilterBloc>().state;
    final filters = <String, dynamic>{};

    if (filterState.selectedState != null && filterState.selectedState!.isNotEmpty) {
      filters['state'] = filterState.selectedState;
    }
    if (filterState.selectedCity != null && filterState.selectedCity!.isNotEmpty) {
      filters['city'] = filterState.selectedCity;
    }
    if (pincodeController.text.isNotEmpty) {
      filters['pincode'] = pincodeController.text;
    }
    if (searchController.text.isNotEmpty) {
      filters['search'] = searchController.text;
    }
    if (latitudeController.text.isNotEmpty) {
      filters['latitude'] = double.tryParse(latitudeController.text);
    }
    if (longitudeController.text.isNotEmpty) {
      filters['longitude'] = double.tryParse(longitudeController.text);
    }
    if (radiusController.text.isNotEmpty) {
      filters['radius'] = double.tryParse(radiusController.text);
    }

    filters['emergencyAvailable'] = filterState.emergencyAvailable;
    filters['isActive'] = filterState.isActive;
    filters['is24x7'] = filterState.is24x7;
    filters['hasAmbulance'] = filterState.hasAmbulance;

    // Apply filters to HomeBloc
    context.read<HomeBloc>().add(OnFilterHospitals(filters));
    
    // Save filters in FilterBloc
    context.read<HospitalFilterBloc>().add(OnApplyFilters(filters));
    
    AppNavigators.pop(context);
  }

  void _resetFilters(BuildContext context) {
    // Reset controllers
    pincodeController.clear();
    searchController.clear();
    latitudeController.clear();
    longitudeController.clear();
    radiusController.clear();

    // Reset FilterBloc
    context.read<HospitalFilterBloc>().add(const OnResetFilters());

    // Reset HomeBloc
    context.read<HomeBloc>().add(OnResetHospitalFilters());

    AppNavigators.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalFilterBloc(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: BlocBuilder<HospitalFilterBloc, HospitalFilterState>(
            builder: (context, filterState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Filter Hospitals',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => AppNavigators.pop(),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // State Dropdown
                    CommonDropdown(
                      items: context.read<HospitalFilterBloc>().stateCityMap.keys.toList(),
                      value: filterState.selectedState,
                      label: 'State',
                      hint: 'Select State',
                      onChanged: (state) {
                        context.read<HospitalFilterBloc>().add(OnStateChanged(state));
                      },
                    ),
                    const SizedBox(height: 12),

                    // City Dropdown
                    CommonDropdown(
                      items: filterState.availableCities,
                      value: filterState.selectedCity,
                      label: 'City',
                      hint: filterState.selectedState == null
                          ? 'Select State First'
                          : 'Select City',
                      onChanged: (city) {
                        context.read<HospitalFilterBloc>().add(OnCityChanged(city));
                      },
                    ),
                    const SizedBox(height: 12),

                    // Pincode TextField
                    CommonTextField(
                      label: 'Pincode',
                      hintText: 'Enter Pincode',
                      controller: pincodeController,
                      keyboardType: TextInputType.number,
                      digitsOnly: true,
                      maxLength: 6,
                    ),
                    const SizedBox(height: 12),

                    // Search TextField
                    CommonTextField(
                      label: 'Search',
                      hintText: 'Search hospitals...',
                      controller: searchController,
                      prefixIcon: const Icon(Icons.search),
                    ),
                    const SizedBox(height: 20),

                    // Location-based search
                    const Text(
                      'Location-based Search',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: CommonTextField(
                            label: 'Latitude',
                            controller: latitudeController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CommonTextField(
                            label: 'Longitude',
                            controller: longitudeController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    CommonTextField(
                      label: 'Radius (km)',
                      controller: radiusController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      prefixIcon: const Icon(Icons.location_on),
                    ),
                    const SizedBox(height: 20),

                    // Boolean Filters
                    const Text(
                      'Facilities',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(height: 12),

                    _buildSwitchTile(
                      context,
                      'Emergency Available',
                      filterState.emergencyAvailable,
                      (val) {
                        context.read<HospitalFilterBloc>().add(OnEmergencyToggled(val));
                      },
                    ),
                    _buildSwitchTile(
                      context,
                      'Active Only',
                      filterState.isActive,
                      (val) {
                        context.read<HospitalFilterBloc>().add(OnActiveToggled(val));
                      },
                    ),
                    _buildSwitchTile(
                      context,
                      '24x7 Service',
                      filterState.is24x7,
                      (val) {
                        context.read<HospitalFilterBloc>().add(On24x7Toggled(val));
                      },
                    ),
                    _buildSwitchTile(
                      context,
                      'Has Ambulance',
                      filterState.hasAmbulance,
                      (val) {
                        context.read<HospitalFilterBloc>().add(OnAmbulanceToggled(val));
                      },
                    ),
                    const SizedBox(height: 20),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _resetFilters(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Reset'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _applyFilters(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: Theme.of(context).primaryColor,
    );
  }
}