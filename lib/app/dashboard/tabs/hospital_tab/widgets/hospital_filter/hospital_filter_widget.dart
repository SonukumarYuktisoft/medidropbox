
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_event.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_state.dart';
import 'package:medidropbox/core/common/CommonDropdown.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/core/helpers/app_export.dart';



 void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const HospitalFilterWidget(),
    );
  }


class HospitalFilterWidget extends StatefulWidget {
  const HospitalFilterWidget({super.key});

  @override
  State<HospitalFilterWidget> createState() => _HospitalFilterWidgetState();
}

class _HospitalFilterWidgetState extends State<HospitalFilterWidget> {


  void _applyFilters(BuildContext context) {
   context.read<HospitalFilterBloc>().add(OnApplyFilters());
    AppNavigators.pop(context);
  }

  void _resetFilters(BuildContext context) {
    context.read<HospitalFilterBloc>().add(OnRefressh());
    AppNavigators.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    items: stateCityMap.keys.toList(),
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
                    hint: 'Select City',
                    onChanged: (city) {
                      context.read<HospitalFilterBloc>().add(OnCityChanged(city));
                    },
                  ),
                  const SizedBox(height: 12),
    
                  // Pincode TextField
                  CommonTextField(
                    label: 'Pincode',
                    hintText: 'Enter Pincode',
                    keyboardType: TextInputType.number,
                    digitsOnly: true,
                    maxLength: 6,
                    onChanged: (d) => context.read<HospitalFilterBloc>().add(OnChangedPinCode(d)),
                  ),
                  const SizedBox(height: 12),
    
                  // Search TextField
                 
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
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                           onChanged: (d) => context.read<HospitalFilterBloc>().add(OnChangedLat(d)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CommonTextField(
                        onChanged: (d) => context.read<HospitalFilterBloc>().add(OnChangedLng(d)),
    
                          label: 'Longitude',
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
    
                  CommonTextField(
                    label: 'Radius (km)',
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    prefixIcon: const Icon(Icons.location_on),
                    onChanged: (d) => context.read<HospitalFilterBloc>().add(OnChangedRadius(d)),
    
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