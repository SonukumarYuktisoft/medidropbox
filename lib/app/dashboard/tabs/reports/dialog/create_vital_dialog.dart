// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:medidropbox/app/models/health_profile/vital_history_model.dart';
import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/overlay_loading.dart';

void showCreateVitalsDialog(BuildContext context,{VitalHistoryModel? vital}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) =>  CreateVitalsDialog(vital: vital),
  );
}

class CreateVitalsDialog extends StatefulWidget {
  final VitalHistoryModel? vital;
  const CreateVitalsDialog({super.key,this.vital});

  @override
  State<CreateVitalsDialog> createState() => _CreateVitalsDialogState();
}

class _CreateVitalsDialogState extends State<CreateVitalsDialog> {
  final _formKey = GlobalKey<FormState>();
  final _weight = TextEditingController();
  final _glucose = TextEditingController();
  final _systolic = TextEditingController();
  final _diastolic = TextEditingController();
  final _notes = TextEditingController();
  DateTime _recordedAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    if(widget.vital!=null){
      setState(() {
        var data = widget.vital!;
        _weight.text = data.weightKg.toString();
        _glucose.text = data.bloodGlucoseMgdl.toString();
        _systolic.text = data.bloodPressureSystolic.toString();
        _diastolic.text = data.bloodPressureDiastolic.toString();
        _diastolic.text = data.bloodPressureDiastolic.toString();
        _notes.text = data.notes.toString();
      });
    }
  }

  @override
  void dispose() {
    _weight.dispose();
    _glucose.dispose();
    _systolic.dispose();
    _diastolic.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthProfileBloc, HealthProfileState>(
      listenWhen: (previous, current) => previous.createVitalStatus!=current.createVitalStatus,
      listener: (context, state) {
        if(state.createVitalStatus==ApiStatus.loading){
         showOverlayLoading(context); 
        }
        if(state.createVitalStatus==ApiStatus.error){
          AppNavigators.pop();
          AppSnackbar.showError(state.mess);
          
        }
        if(state.createVitalStatus==ApiStatus.success){
           context.read<HealthProfileBloc>().add(OnBMIReportApi());
         context.read<HealthProfileBloc>().add(OnGetLatestVitalApi());
        context.read<HealthProfileBloc>().add(OnGetVitalHistoryApi());
          AppNavigators.pop();
          AppNavigators.pop();
          AppSnackbar.showSuccess(state.mess);

          
        }
       
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with gradient
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.red.shade400, Colors.red.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "${widget.vital!=null?"Edit":"Add"} Vitals",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.white),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Date & Time Picker
                        if(widget.vital==null)...[
                        _buildDateTimeCard(),
                        SizedBox(height: 16),

                        ],
                     
                        _buildVitalCard(
                          controller: _weight,
                          label: "Weight",
                          unit: "kg",
                          icon: Icons.monitor_weight_outlined,
                          color: Colors.blue,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Weight is required';
                            }
                            final weight = double.tryParse(val);
                            if (weight == null || weight <= 0) {
                              return 'Enter valid weight';
                            }
                            if (weight > 300) {
                              return 'Weight seems too high';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        _buildVitalCard(
                          controller: _glucose,
                          label: "Blood Glucose",
                          unit: "mg/dL",
                          icon: Icons.bloodtype_outlined,
                          color: Colors.orange,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Glucose is required';
                            }
                            final glucose = double.tryParse(val);
                            if (glucose == null || glucose <= 0) {
                              return 'Enter valid glucose level';
                            }
                            if (glucose > 600) {
                              return 'Value seems too high';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        // Blood Pressure Row
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.red.shade100),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.red.shade600,
                                    size: 20,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Blood Pressure *",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildBPInput(
                                      _systolic,
                                      "Systolic",
                                      Icons.arrow_upward,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Required';
                                        }
                                        final sys = int.tryParse(val);
                                        if (sys == null ||
                                            sys < 70 ||
                                            sys > 250) {
                                          return 'Invalid';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text(
                                      "/",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red.shade300,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildBPInput(
                                      _diastolic,
                                      "Diastolic",
                                      Icons.arrow_downward,
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return 'Required';
                                        }
                                        final dia = int.tryParse(val);
                                        if (dia == null ||
                                            dia < 40 ||
                                            dia > 150) {
                                          return 'Invalid';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),

                        // Notes (Optional)
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: TextField(
                            controller: _notes,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: "Notes (Optional)",
                              hintText: "Add any additional notes...",
                              prefixIcon: Icon(
                                Icons.note_outlined,
                                color: Colors.grey.shade600,
                              ),
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Action Buttons
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.red.shade600,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Save Vitals",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimeCard() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _recordedAt,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(_recordedAt),
          );
          if (time != null) {
            setState(() {
              _recordedAt = DateTime(
                date.year,
                date.month,
                date.day,
                time.hour,
                time.minute,
              );
            });
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.purple.shade200),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.calendar_today,
                color: Colors.purple.shade600,
                size: 22,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recorded Date & Time *",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${_recordedAt.day}/${_recordedAt.month}/${_recordedAt.year} at ${_recordedAt.hour.toString().padLeft(2, '0')}:${_recordedAt.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit, color: Colors.purple.shade400, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard({
    required TextEditingController controller,
    required String label,
    required String unit,
    required IconData icon,
    required Color color,
    required String? Function(String?) validator,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$label *",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: validator,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter value",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.normal,
                    ),
                    suffixText: unit,
                    suffixStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                    errorStyle: TextStyle(fontSize: 10, height: 0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBPInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    required String? Function(String?) validator,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.red.shade400, size: 16),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.red.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          validator: validator,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red.shade700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade700, width: 2),
            ),
            hintText: "--",
            hintStyle: TextStyle(color: Colors.grey.shade400),
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            errorStyle: TextStyle(fontSize: 9, height: 0.5),
          ),
        ),
      ],
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields correctly'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if(widget.vital!=null){
  context.read<HealthProfileBloc>().add(
      OnEditVitalsEvent(
        weightKg: double.parse(_weight.text),
        bloodGlucoseMgdl: double.parse(_glucose.text),
        bloodPressureSystolic: int.parse(_systolic.text),
        bloodPressureDiastolic: int.parse(_diastolic.text),
        notes: _notes.text.trim().isEmpty ? '' : _notes.text.trim(),
        id:widget.vital!.id.toString(),
      ),
    );
    }else{
        context.read<HealthProfileBloc>().add(
      OnCreateVitalsEvent(
        weightKg: double.parse(_weight.text),
        bloodGlucoseMgdl: double.parse(_glucose.text),
        bloodPressureSystolic: int.parse(_systolic.text),
        bloodPressureDiastolic: int.parse(_diastolic.text),
        recordedAt: _recordedAt.toIso8601String(),
        notes: _notes.text.trim().isEmpty ? '' : _notes.text.trim(),
      ),
    );
    }
  }
}
