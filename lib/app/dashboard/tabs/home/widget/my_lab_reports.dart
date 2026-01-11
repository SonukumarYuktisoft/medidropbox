import 'package:medidropbox/app/models/lab_report/lab_report_model.dart';
import 'package:medidropbox/app/views/all_lab_report/all_lab_report.dart';
import 'package:medidropbox/app/views/all_lab_report/lab_reports_details_view.dart';
import 'package:medidropbox/app/views/upload_lab_report/bloc/upload_lab_report_bloc.dart';
import 'package:medidropbox/core/extensions/button_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_shimmer/horizental_list_shimmer.dart';

class MyLabReports extends StatefulWidget {
  const MyLabReports({super.key});

  @override
  State<MyLabReports> createState() => _MyLabReportsState();
}

class _MyLabReportsState extends State<MyLabReports> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadLabReportBloc, UploadLabReportState>(
      buildWhen: (previous, current) => previous.labReportStatus != current.labReportStatus,
      builder: (context, state) {
        if (state.labReportStatus == ApiStatus.loading) {
          return const HorizentalListShimmer(
            horizontalMargin: 15,
            width: 170,
            height: 130,
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
          return _buildReportsSection(data);
        }

        return const SizedBox();
      },
    );
  }


  Widget _buildReportsSection(List<LabReportModel> reports) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(reports.length),
     
        const SizedBox(height: 16),
        _buildReportsList(reports),
      ],
    );
  }

  Widget _buildHeader(int count) {
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
                '$count ${count == 1 ? 'report' : 'reports'} available',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          "View All".toHeadingText(
            color: Colors.blue
          ).asTextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>AllLabReport()));
          }),
       
        ],
      ),
    );
  }


  Widget _buildReportsList(List<dynamic> reports) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: reports.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: _animationController,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.3, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Interval(
                  index * 0.1,
                  1.0,
                  curve: Curves.easeOut,
                ),
              )),
              child: _buildReportCard(reports[index]),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReportCard(LabReportModel report) {
    final reportType = report.reportType ?? 'UNKNOWN';
    final doctorName = report.doctorName ?? 'Unknown Doctor';
    final labName = report.labName ?? 'Unknown Lab';
    final reportDate = report.reportDate ?? '';
    final fileUrl = report.fileUrl ?? '';

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 12),
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
            height: 110,
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
                      colors: [Colors.blue[400]!, Colors.blue[600]!],
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
                      size: 40,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
              ],
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.local_hospital_outlined, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        labName,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 14, color: Colors.grey[500]),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        doctorName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(reportDate.toString()),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        // Handle view report action
                      },
                      child: Container(
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
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue[700],
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(Icons.arrow_forward_ios_rounded, size: 10, color: Colors.blue[700]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).onTap((){

        Navigator.push(context, MaterialPageRoute(
          builder: (_)=>LabReportsDetailsView(report.id.toString())));
      
    });
  }

  Widget _buildReportTypeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        type.replaceAll('_', ' '),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: _getReportColor(type),
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
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.description_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No Lab Reports Yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Upload your first lab report to get started',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              // Handle upload action
            },
            icon: const Icon(Icons.upload_file, size: 20),
            label: const Text('Upload Report'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
          const SizedBox(height: 16),
          Text(
            'Unable to Load Reports',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Please check your connection and try again',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.red[700],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              context.read<UploadLabReportBloc>().add(GetLabReportApi());
              // Handle retry action
            },
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}