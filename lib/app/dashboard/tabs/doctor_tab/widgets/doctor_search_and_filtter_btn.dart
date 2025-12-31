import 'package:medidropbox/app/dashboard/tabs/doctor_tab/bloc/doctor_tab_bloc.dart' show DoctorTabBloc, OnChangedSearch, OnApplyFilters;
import 'package:medidropbox/app/dashboard/tabs/doctor_tab/widgets/doctor_filter_sheet.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class DoctorSearchAndFiltterBtn extends StatefulWidget {
  const DoctorSearchAndFiltterBtn({super.key});

  @override
  State<DoctorSearchAndFiltterBtn> createState() => _DoctorSearchAndFiltterBtnState();
}

class _DoctorSearchAndFiltterBtnState extends State<DoctorSearchAndFiltterBtn> {
    final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (d)=> context.read<DoctorTabBloc>().add(OnChangedSearch(d)),
                    decoration: InputDecoration(
                      hintText: 'Search hospitals...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                               context.read<DoctorTabBloc>().add(OnApplyFilters());
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade800],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                    onPressed:()=> showDoctorFilterSheet(context),
                  ),
                ),
              ],
            ),
          );
  }
}