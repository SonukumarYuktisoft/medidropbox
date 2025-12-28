import 'package:medidropbox/app/dashboard/dashboard_widget/hospital_dropdown.dart';
import 'package:medidropbox/app/dashboard/tabs/home/bloc/home_bloc.dart';
import 'package:medidropbox/app/dashboard/tabs/home/widget/hospital_card.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_card.dart';
import 'package:medidropbox/app/dashboard/tabs/hospital_tab/widgets/hospital_filter/hospital_filter_widget.dart';
import 'package:medidropbox/core/extensions/container_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/horizental_grid_Shimmer.dart';
import 'package:medidropbox/core/helpers/app_shimmer/horizental_list_shimmer.dart';
import 'package:medidropbox/core/helpers/app_shimmer/hospital_shimmer/hospital_card_shimmer/hospital_grid_card_shimmer.dart';
import 'package:medidropbox/core/helpers/app_shimmer/vertical_grid_shimmer.dart';
import 'package:medidropbox/core/helpers/carousel/app_carousel.dart';
import 'package:medidropbox/core/helpers/carousel/app_multiItem_carousel.dart';
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
    context.read<HomeBloc>().add(OnGetAllHospital());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<HomeBloc>().state;
      if (state.hasMoreHospitals && !state.isLoadingMore) {
        context.read<HomeBloc>().add(OnLoadMoreHospitals());
      }
    }
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const HospitalFilterWidget(),
    );
  }

  void _onSearchChanged(String query) {
    if (query.isEmpty) {
      context.read<HomeBloc>().add(OnResetHospitalFilters());
    } else {
      context.read<HomeBloc>().add(OnSearchHospitals(query));
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
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search hospitals...',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _onSearchChanged('');
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
                    onPressed: _showFilterBottomSheet,
                  ),
                ),
              ],
            ),
          ),

          // Hospital Grid
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.allHospitalStatus == ApiStatus.error) {
                  return RefreshView(
                    onPressed: () =>
                        context.read<HomeBloc>().add(OnGetAllHospital()),
                  ).radiusContainer(
                    color: Colors.grey.shade300,
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    padding: const EdgeInsets.symmetric(vertical: 40),
                  );
                } else if (state.allHospitalStatus == ApiStatus.loading) {
                  return const HospitalGridCardShimmer();
                } else if (state.allHospitalStatus == ApiStatus.success) {
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
                            onPressed: () => context
                                .read<HomeBloc>()
                                .add(OnResetHospitalFilters()),
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
                            childAspectRatio: 0.75,
                          ),
                          itemCount: state.allHospitalList!.length,
                          itemBuilder: (context, index) {
                            final hospital = state.allHospitalList![index];
                            return HospitalTabCard(hospital: hospital);
                          },
                        ),
                      ),
                      
                      // Loading More Indicator
                      if (state.isLoadingMore)
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue.shade600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Loading more...',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
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