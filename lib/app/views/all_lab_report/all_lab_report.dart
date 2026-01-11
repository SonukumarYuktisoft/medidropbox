import 'package:medidropbox/app/models/lab_report/lab_report_model.dart';
import 'package:medidropbox/app/views/all_lab_report/lab_reports_details_view.dart';
import 'package:medidropbox/app/views/upload_lab_report/bloc/upload_lab_report_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';

class AllLabReport extends StatefulWidget {
  const AllLabReport({super.key});

  @override
  State<AllLabReport> createState() => _AllLabReportState();
}

class _AllLabReportState extends State<AllLabReport> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<LabReportModel> _filterReports(List<LabReportModel> reports) {
    if (_selectedFilter == 'All') return reports;
    return reports.where((report) => report.reportType == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: "Reports".toHeadingText(color: Colors.white),
      ),
      body: BlocBuilder<UploadLabReportBloc, UploadLabReportState>(
        buildWhen: (previous, current) => previous.labReportStatus != current.labReportStatus,
        builder: (context, state) {
          if (state.labReportStatus == ApiStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.labReportStatus == ApiStatus.error) {
            return _buildErrorState();
          }

          if (state.labReportStatus == ApiStatus.success) {
            var data = state.labReportList;
            if (data == null || data.isEmpty) {
              return _buildEmptyState();
            }
            
            var filteredData = _filterReports(data);
            return _buildReportsSection(filteredData, data.length);
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildReportsSection(List<LabReportModel> reports, int totalCount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _buildHeader(totalCount, reports.length),
        const SizedBox(height: 16),
        _buildFilterChips(),
        const SizedBox(height: 16),
        Expanded(
          child: _buildReportsGrid(reports),
        ),
      ],
    );
  }

  Widget _buildHeader(int totalCount, int filteredCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Lab Reports',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _selectedFilter == 'All'
                    ? '$totalCount ${totalCount == 1 ? 'report' : 'reports'} available'
                    : '$filteredCount of $totalCount reports',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'XRAY', 'BLOOD', 'MRI', 'CT_SCAN', 'ULTRASOUND'];

    return SizedBox(
      height: 45,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                filter.replaceAll('_', ' '),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                  _animationController.reset();
                  _animationController.forward();
                });
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Colors.blue[600],
              checkmarkColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(
                  color: isSelected ? Colors.blue[600]! : Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportsGrid(List<LabReportModel> reports) {
    if (reports.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.filter_list_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No ${_selectedFilter.replaceAll('_', ' ')} Reports',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try selecting a different filter',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: _animationController,
              curve: Interval(
                index * 0.1 > 1.0 ? 0.0 : index * 0.1,
                1.0,
                curve: Curves.easeOut,
              ),
            )),
            child: _buildReportCard(reports[index]),
          ),
        );
      },
    );
  }

  Widget _buildReportCard(LabReportModel report) {
    final reportType = report.reportType ?? 'UNKNOWN';
    final doctorName = report.doctorName ?? 'Unknown Doctor';
    final labName = report.labName ?? 'Unknown Lab';
    final reportDate = report.reportDate ?? '';
    final fileUrl = report.fileUrl ?? '';

    return InkWell(
      onTap: () {
    
        Navigator.push(context, MaterialPageRoute(
          builder: (_)=>LabReportsDetailsView(report.id.toString())));
      
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Header with Gradient Overlay
            Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: fileUrl.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(fileUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
                gradient: fileUrl.isEmpty
                    ? LinearGradient(
                        colors: [
                          _getReportColor(reportType).withOpacity(0.7),
                          _getReportColor(reportType),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: Stack(
                children: [
                  if (fileUrl.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _buildReportTypeBadge(reportType),
                  ),
                  if (fileUrl.isEmpty)
                    Center(
                      child: Icon(
                        _getReportIcon(reportType),
                        size: 48,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                ],
              ),
            ),

            // Content Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          labName,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey[900],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.person_outline, size: 12, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                doctorName,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today_outlined, size: 11, color: Colors.grey[500]),
                            const SizedBox(width: 4),
                            Text(
                              _formatDate(reportDate.toString()),
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'View',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
                                ),
                              ),
                              const SizedBox(width: 2),
                              Icon(Icons.arrow_forward_ios_rounded, size: 8, color: Colors.blue[700]),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        type.replaceAll('_', ' '),
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: _getReportColor(type),
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  IconData _getReportIcon(String type) {
    switch (type) {
      case 'XRAY':
        return Icons.healing_outlined;
      case 'BLOOD':
        return Icons.bloodtype_outlined;
      case 'MRI':
        return Icons.scanner_outlined;
      case 'CT_SCAN':
        return Icons.medical_services_outlined;
      case 'ULTRASOUND':
        return Icons.monitor_heart_outlined;
      default:
        return Icons.description_outlined;
    }
  }

  Color _getReportColor(String type) {
    switch (type) {
      case 'XRAY':
        return Colors.purple[700]!;
      case 'BLOOD':
        return Colors.red[700]!;
      case 'MRI':
        return Colors.blue[700]!;
      case 'CT_SCAN':
        return Colors.teal[700]!;
      case 'ULTRASOUND':
        return Colors.orange[700]!;
      default:
        return Colors.grey[700]!;
    }
  }

  String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date);
      final now = DateTime.now();
      final difference = now.difference(parsedDate).inDays;

      if (difference == 0) {
        return 'Today';
      } else if (difference == 1) {
        return 'Yesterday';
      } else if (difference < 7) {
        return '$difference days ago';
      } else {
        return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
      }
    } catch (e) {
      return date;
    }
  }

  Widget _buildEmptyState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.description_outlined, size: 64, color: Colors.blue[400]),
            ),
            const SizedBox(height: 24),
            Text(
              'No Lab Reports Yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Upload your first lab report to get started\nand keep track of your health',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () {
                // Handle upload action
              },
              icon: const Icon(Icons.upload_file, size: 22),
              label: const Text('Upload Report', style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.red[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            ),
            const SizedBox(height: 24),
            Text(
              'Unable to Load Reports',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red[900],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Please check your internet connection\nand try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.red[700],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () {
                context.read<UploadLabReportBloc>().add(GetLabReportApi());
              },
              icon: const Icon(Icons.refresh, size: 22),
              label: const Text('Retry', style: TextStyle(fontSize: 15)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}