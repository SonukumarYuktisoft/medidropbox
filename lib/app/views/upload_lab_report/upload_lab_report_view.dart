import 'package:file_picker/file_picker.dart';
import 'package:medidropbox/app/views/upload_lab_report/bloc/upload_lab_report_bloc.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/overlay_loading.dart';

class UploadLabReportView extends StatefulWidget {
  const UploadLabReportView({super.key});

  @override
  State<UploadLabReportView> createState() => _UploadLabReportViewState();
}

class _UploadLabReportViewState extends State<UploadLabReportView> {
  final _formKey = GlobalKey<FormState>();
  final _reportTypeController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final _labNameController = TextEditingController();
  final _aiSummaryController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedReportType;
  PlatformFile? _selectedFile;

  final List<String> _reportTypes = [
    'XRAY',
    'Blood Test',
    'MRI',
    'CT Scan',
    'Ultrasound',
    'ECG',
    'Other',
  ];

  @override
  void dispose() {
    _reportTypeController.dispose();
    _doctorNameController.dispose();
    _labNameController.dispose();
    _aiSummaryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('File selected: ${_selectedFile!.name}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedFile != null) {
      // Handle form submission
      //
      context.read<UploadLabReportBloc>().add(
        OnUploadLabReport(
          date: "${_selectedDate?.toString().split(' ')[0]}",
          reportType: _selectedReportType!,
          labReportFile: _selectedFile!.path!,
          doctorName: _doctorNameController.text,
          labName: _labNameController.text,
          aiSummary: _aiSummaryController.text,
          notes: _notesController.text,
        ),
      );
    } else {
      if (_selectedDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a report date')),
        );
      }
      if (_selectedFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a lab report file')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Lab Report'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: BlocListener<UploadLabReportBloc, UploadLabReportState>(
        listenWhen: (previous, current) => previous.status!=current.status,
        listener: (context, state) {
         if(state.status==ApiStatus.loading){
          showOverlayLoading(context);
         }


         if(state.status==ApiStatus.error){
          AppNavigators.pop();
          AppSnackbar.showError(state.mess);
         }


         if(state.status==ApiStatus.success){
          AppNavigators.pop();
          AppNavigators.pop();
          AppSnackbar.showSuccess(state.mess);
         }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Report Type Dropdown
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Report Type *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedReportType,
                            decoration: InputDecoration(
                              hintText: 'Select report type',
                              prefixIcon: const Icon(Icons.medical_information),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            items: _reportTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedReportType = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a report type';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lab Report File Upload
                  Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: _pickFile,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Lab Report *',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _selectedFile == null
                                      ? Colors.grey.shade300
                                      : Colors.teal,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[50],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedFile == null
                                        ? Icons.cloud_upload_outlined
                                        : Icons.check_circle,
                                    size: 40,
                                    color: _selectedFile == null
                                        ? Colors.grey
                                        : Colors.teal,
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _selectedFile == null
                                              ? 'Upload Lab Report'
                                              : _selectedFile!.name,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: _selectedFile == null
                                                ? Colors.grey[700]
                                                : Colors.black,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _selectedFile == null
                                              ? 'PDF, Image, DOC, etc.'
                                              : '${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                    color: Colors.grey[400],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Report Date
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Report Date *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_today),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              child: Text(
                                _selectedDate == null
                                    ? 'Select date'
                                    : _selectedDate.toString().split(' ')[0],
                                style: TextStyle(
                                  color: _selectedDate == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Doctor Name
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Doctor Name *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _doctorNameController,
                            decoration: InputDecoration(
                              hintText: 'e.g., Dr. Sharma',
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter doctor name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Lab Name
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lab Name *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _labNameController,
                            decoration: InputDecoration(
                              hintText: 'e.g., Apollo Labs',
                              prefixIcon: const Icon(Icons.local_hospital),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter lab name';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // AI Summary
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'AI Summary *',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _aiSummaryController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText:
                                  'e.g., No fracture detected. Mild swelling.',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 50),
                                child: Icon(Icons.psychology),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter AI summary';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Notes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _notesController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: 'e.g., Follow-up required',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(bottom: 70),
                                child: Icon(Icons.note),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Upload Report',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
