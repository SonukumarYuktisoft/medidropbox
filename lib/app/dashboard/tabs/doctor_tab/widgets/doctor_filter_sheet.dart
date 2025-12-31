import 'package:medidropbox/app/dashboard/tabs/doctor_tab/bloc/doctor_tab_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

void showDoctorFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const DoctorFilterSheet(),
  );
}

class DoctorFilterSheet extends StatefulWidget {
  const DoctorFilterSheet({super.key});

  @override
  State<DoctorFilterSheet> createState() => _DoctorFilterSheetState();
}

class _DoctorFilterSheetState extends State<DoctorFilterSheet> {
  double minRating = 4;
  double maxRating = 5;
  double minFees = 0;
  double maxFees = 1000;
  bool isActive = false;
  bool allowRemote = false;
  String specialty = 'Cardiology';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// DRAG HANDLE
          Center(
            child: Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          /// TITLE
          const Text(
            "Filter Doctors",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// SPECIALTY
          _sectionTitle("Specialty"),
          DropdownButtonFormField<String>(
            value: specialty,
            items: const [
              DropdownMenuItem(value: 'Cardiology', child: Text('Cardiology')),
              DropdownMenuItem(value: 'Dermatology', child: Text('Dermatology')),
              DropdownMenuItem(value: 'Orthopedic', child: Text('Orthopedic')),
            ],
            onChanged: (v) => setState(() => specialty = v!),
            decoration: _inputDecoration(),
          ),

          const SizedBox(height: 16),

          /// RATING
          _sectionTitle("Rating (${minRating.toInt()} - ${maxRating.toInt()})"),
          RangeSlider(
            values: RangeValues(minRating, maxRating),
            min: 1,
            max: 5,
            divisions: 4,
            labels: RangeLabels(
              minRating.toStringAsFixed(1),
              maxRating.toStringAsFixed(1),
            ),
            onChanged: (v) {
              setState(() {
                minRating = v.start;
                maxRating = v.end;
              });
            },
          ),

          const SizedBox(height: 16),

          /// FEES
          _sectionTitle("Fees (₹${minFees.toInt()} - ₹${maxFees.toInt()})"),
          RangeSlider(
            values: RangeValues(minFees, maxFees),
            min: 0,
            max: 5000,
            divisions: 50,
            onChanged: (v) {
              setState(() {
                minFees = v.start;
                maxFees = v.end;
              });
            },
          ),

          const SizedBox(height: 12),

          /// SWITCHES
          SwitchListTile(
            title: const Text("Active Doctors"),
            value: isActive,
            onChanged: (v) => setState(() => isActive = v),
          ),

          SwitchListTile(
            title: const Text("Allow Remote Consultation"),
            value: allowRemote,
            onChanged: (v) => setState(() => allowRemote = v),
          ),

          const SizedBox(height: 20),

          /// ACTION BUTTONS
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      minRating = 1;
                      maxRating = 5;
                      minFees = 0;
                      maxFees = 1000;
                      isActive = false;
                      allowRemote = false;
                      specialty = 'Cardiology';
                    });
                    context.read<DoctorTabBloc>().add(OnRefressh());
                    AppNavigators.pop();

                  },
                  child: const Text("Clear"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final bloc = context.read<DoctorTabBloc>();

                    bloc.add(OnChangedSpecialty(specialty));
                    bloc.add(OnChangedMinRating(minRating.toString()));
                    bloc.add(OnChangedMaxRating(maxRating.toString()));
                    bloc.add(OnChangedMinFess(minFees.toString()));
                    bloc.add(OnChangedMaxFess(maxFees.toString()));
                    bloc.add(OnChangedIsActive(isActive));
                    bloc.add(OnChangedAllowRemote(allowRemote.toString()));
                    bloc.add(OnApplyFilters());
                    Navigator.pop(context);
                  },
                  child: const Text("Apply Filters"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// COMMON UI
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
