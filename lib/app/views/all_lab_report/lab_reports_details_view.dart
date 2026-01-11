import 'package:medidropbox/app/models/lab_report/lab_report_model.dart';
import 'package:medidropbox/app/views/upload_lab_report/bloc/upload_lab_report_bloc.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/data_loading.dart';
import 'package:medidropbox/core/helpers/data_not_found.dart';
import 'package:medidropbox/core/helpers/refresh_view.dart';

class LabReportsDetailsView extends StatefulWidget {
  final String id;
  const LabReportsDetailsView(this.id, {super.key});

  @override
  State<LabReportsDetailsView> createState() => _LabReportsDetailsViewState();
}

class _LabReportsDetailsViewState extends State<LabReportsDetailsView> {
  @override
  void initState() {
    context.read<UploadLabReportBloc>().add(GetLabReportByIdApi(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Report Details".toHeadingText(color: Colors.white),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.share_outlined),
        //     onPressed: () {
        //       // Handle share
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(Icons.download_outlined),
        //     onPressed: () {
        //       // Handle download
        //     },
        //   ),
        //   PopupMenuButton(
        //     icon: const Icon(Icons.more_vert),
        //     itemBuilder: (context) => [
        //       const PopupMenuItem(
        //         value: 'edit',
        //         child: Row(
        //           children: [
        //             Icon(Icons.edit_outlined, size: 20),
        //             SizedBox(width: 12),
        //             Text('Edit Report'),
        //           ],
        //         ),
        //       ),
        //       const PopupMenuItem(
        //         value: 'delete',
        //         child: Row(
        //           children: [
        //             Icon(Icons.delete_outline, size: 20, color: Colors.red),
        //             SizedBox(width: 12),
        //             Text('Delete Report', style: TextStyle(color: Colors.red)),
        //           ],
        //         ),
        //       ),
        //     ],
        //     onSelected: (value) {
        //       if (value == 'edit') {
        //         // Handle edit
        //       } else if (value == 'delete') {
        //         // Handle delete
        //       }
        //     },
        //   ),
        // ],
      ),
      body: BlocBuilder<UploadLabReportBloc, UploadLabReportState>(
        builder: (context, state) {
          if (state.labReportDetailsStatus == ApiStatus.loading) {
            return DataLoading();
          }
          if (state.labReportDetailsStatus == ApiStatus.error) {
            return RefreshView(
              onPressed: () => context.read<UploadLabReportBloc>().add(GetLabReportByIdApi(widget.id)),
            );
          }
          if (state.labReportDetailsStatus == ApiStatus.success) {
            LabReportModel? data = state.labReportDetails;
            if (data == null) {
              return DataNotFound();
            }
            return _details(data);
          }
          return Container();
        },
      ),
    );
  }

  Widget _details(LabReportModel data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Report Image/Preview Section
          _buildImageSection(data),

          // Report Type Badge
          _buildReportTypeBanner(data),

          // Main Information Cards
          _buildMainInfoSection(data),

          // AI Summary Card
          if (data.aiSummary != null && data.aiSummary!.isNotEmpty && data.aiSummary != 'not found')
            _buildAISummaryCard(data),

          // Doctor & Lab Information
          _buildDoctorLabInfo(data),

          // Additional Details
          _buildAdditionalDetails(data),

          // Notes Section
          if (data.notes != null && data.notes!.isNotEmpty)
            _buildNotesSection(data),

          // File Information
          _buildFileInfo(data),

         // const SizedBox(height: 24),

          // Action Buttons
        //  _buildActionButtons(data),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildImageSection(LabReportModel data) {
    final fileUrl = data.fileUrl ?? '';
    
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        image: fileUrl.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(fileUrl),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        children: [
          if (fileUrl.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          if (fileUrl.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getReportIcon(data.reportType ?? ''),
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Preview Available',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          if (fileUrl.isNotEmpty)
            Positioned(
              bottom: 16,
              right: 16,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.zoom_in_outlined),
                  onPressed: () {
                    // Handle full screen view
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReportTypeBanner(LabReportModel data) {
    final reportType = data.reportType ?? 'UNKNOWN';
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _getReportColor(reportType).withOpacity(0.1),
            _getReportColor(reportType).withOpacity(0.05),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getReportColor(reportType).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getReportIcon(reportType),
              color: _getReportColor(reportType),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reportType.replaceAll('_', ' '),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _getReportColor(reportType),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Medical Report',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _getReportColor(reportType),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data.fileFormat ?? 'IMAGE',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfoSection(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Report Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow(
                Icons.calendar_today_outlined,
                'Report Date',
                _formatFullDate(data.reportDate),
                Colors.blue,
              ),
              const Divider(height: 24),
              _buildInfoRow(
                Icons.access_time_outlined,
                'Created On',
                _formatFullDate(data.createdAt),
                Colors.green,
              ),
              const Divider(height: 24),
              _buildInfoRow(
                Icons.update_outlined,
                'Last Updated',
                _formatFullDate(data.updatedAt),
                Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAISummaryCard(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.auto_awesome, color: Colors.blue[700], size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'AI Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  data.aiSummary ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorLabInfo(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.purple[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person_outline, color: Colors.purple[700], size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Doctor',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.doctorName ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.teal[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.local_hospital_outlined, color: Colors.teal[700], size: 28),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Laboratory',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.labName ?? 'Unknown',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalDetails(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Additional Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 16),
              _buildDetailRow('Report ID', '#${data.id ?? 'N/A'}'),
              const SizedBox(height: 12),
              _buildDetailRow('Patient ID', '#${data.patientId ?? 'N/A'}'),
              const SizedBox(height: 12),
              _buildDetailRow('File Name', data.fileName ?? 'Unknown'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotesSection(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.amber[50],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.note_outlined, color: Colors.amber[700], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[900],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                data.notes ?? '',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileInfo(LabReportModel data) {
    final fileSizeKB = (data.fileSize ?? 0) / 1024;
    final fileSizeStr = fileSizeKB > 1024
        ? '${(fileSizeKB / 1024).toStringAsFixed(2)} MB'
        : '${fileSizeKB.toStringAsFixed(2)} KB';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'File Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildFileInfoItem(
                      Icons.insert_drive_file_outlined,
                      'Format',
                      data.fileFormat ?? 'Unknown',
                      Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFileInfoItem(
                      Icons.storage_outlined,
                      'Size',
                      fileSizeStr,
                      Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(LabReportModel data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle download
              },
              icon: const Icon(Icons.download_outlined),
              label: const Text('Download'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                // Handle share
              },
              icon: const Icon(Icons.share_outlined),
              label: const Text('Share'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(color: Colors.blue[600]!, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        20.widthBox,
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileInfoItem(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
        ],
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

  String _formatFullDate(DateTime? date) {
    if (date == null) return 'Not available';
    
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}