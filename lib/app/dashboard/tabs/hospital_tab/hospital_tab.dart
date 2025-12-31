import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_event.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/bloc/hospital_filter_state.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_card.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/hospital_filter_widget.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/app_page_loader.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_card_shimmer/hospital_grid_card_shimmer.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class HospitalTab extends StatefulWidget {
  const HospitalTab({super.key});

  @override
  State<HospitalTab> createState() => _HospitalTabState();
}

class _HospitalTabState extends State<HospitalTab> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HospitalFilterBloc>().add(OnRefressh());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == 
        _scrollController.position.maxScrollExtent) {
     context.read<HospitalFilterBloc>().add(OnPageNation());
    }
  }

 



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (d)=> context.read<HospitalFilterBloc>().add(OnChangedSearch(d)),
                    decoration: InputDecoration(
                      hintText: 'Search hospitals...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                               context.read<HospitalFilterBloc>().add(OnApplyFilters());
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
                    onPressed:()=> showFilterBottomSheet(context),
                  ),
                ),
              ],
            ),
          ),

          // Hospital Grid
          Expanded(
            child: BlocBuilder<HospitalFilterBloc, HospitalFilterState>(
              builder: (context, state) {
                 if (state.allHospitalStatus == ApiStatus.loading) {
                  return const HospitalGridCardShimmer();
                }
                if (state.allHospitalStatus == ApiStatus.error) {
                  return RefreshView(
                    onPressed: () =>
                        context.read<HospitalFilterBloc>().add(OnRefressh()),
                  ).radiusContainer(
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                  );
                }  else if (state.allHospitalStatus == ApiStatus.success) {
                  if (state.allHospitalList?.isEmpty ?? true) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.local_hospital_outlined,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hospitals found',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your filters',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                             
                               context.read<HospitalFilterBloc>().add(OnRefressh());
                                _searchController.clear();
                            },

                            icon: const Icon(Icons.refresh),
                            label: const Text('Clear filters'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: ()async {
                            context.read<HospitalFilterBloc>().add(OnRefressh());
                          },
                          child: GridView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.70,
                            ),
                            itemCount: state.allHospitalList!.length,
                            itemBuilder: (context, index) {
                              final hospital = state.allHospitalList![index];
                              return HospitalTabCard(hospital: hospital);
                            },
                          ),
                        ),
                      ),

                      AppPaginationLoader<HospitalFilterBloc, HospitalFilterState>(
                        getPageStatus: (d)=>d.pageStatus)
                      
                   
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}