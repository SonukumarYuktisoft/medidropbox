import 'package:medidropbox/app/views/health_profile/bloc/health_profile_bloc.dart';
import 'package:medidropbox/core/common/app_snackbaar.dart';
import 'package:medidropbox/core/helpers/app_export.dart';
import 'package:medidropbox/core/helpers/app_loader/overlay_loading.dart';

void showUpdateHealthProfileDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const UpdateHealthProfileDialog(),
  );
}

class UpdateHealthProfileDialog extends StatefulWidget {
  const UpdateHealthProfileDialog({super.key});

  @override
  State<UpdateHealthProfileDialog> createState() =>
      _UpdateHealthProfileDialogState();
}

class _UpdateHealthProfileDialogState
    extends State<UpdateHealthProfileDialog> {
  final _formKey = GlobalKey<FormState>();

  final _height = TextEditingController();
  final _dob = TextEditingController();

  String _selectedGender = "MALE";
  String _selectedBloodGroup = "A_POSITIVE";
  DateTime _selectedDate = DateTime(1990, 5, 15);

  @override
  void dispose() {
    _height.dispose();
    _dob.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HealthProfileBloc, HealthProfileState>(
      listenWhen: (p, c) => p.updateProfileStatus != c.updateProfileStatus,
      listener: (context, state) {
        if (state.updateProfileStatus == ApiStatus.loading) {
          showOverlayLoading(context);
        }
        if (state.updateProfileStatus == ApiStatus.error) {
          AppNavigators.pop();
          AppSnackbar.showError(state.mess);
        }
        if (state.updateProfileStatus == ApiStatus.success) {
          context.read<HealthProfileBloc>().add(OnGetHealthProfile());
          AppNavigators.pop();
          AppNavigators.pop();
          AppSnackbar.showSuccess(state.mess);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Update Health Profile",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                _buildHeightField(),
                const SizedBox(height: 16),

                _buildGenderDropdown(),
                const SizedBox(height: 16),

                _buildBloodGroupDropdown(),
                const SizedBox(height: 16),

                _buildDOBPicker(),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: const Text("Update"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Widgets ----------------

  Widget _buildHeightField() {
    return TextFormField(
      controller: _height,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: "Height (cm)",
        border: OutlineInputBorder(),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) return "Height required";
        final h = double.tryParse(val);
        if (h == null || h < 50 || h > 250) return "Enter valid height";
        return null;
      },
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      decoration: const InputDecoration(
        labelText: "Gender",
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: "MALE", child: Text("Male")),
        DropdownMenuItem(value: "FEMALE", child: Text("Female")),
        DropdownMenuItem(value: "OTHER", child: Text("Other")),
      ],
      onChanged: (v) => setState(() => _selectedGender = v!),
    );
  }

  Widget _buildBloodGroupDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBloodGroup,
      decoration: const InputDecoration(
        labelText: "Blood Group",
        border: OutlineInputBorder(),
      ),
      items: const [
        "A_POSITIVE",
        "A_NEGATIVE",
        "B_POSITIVE",
        "B_NEGATIVE",
        "AB_POSITIVE",
        "AB_NEGATIVE",
        "O_POSITIVE",
        "O_NEGATIVE"
      ].map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e.replaceAll("_", " ")),
        );
      }).toList(),
      onChanged: (v) => setState(() => _selectedBloodGroup = v!),
    );
  }

  Widget _buildDOBPicker() {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() {
            _selectedDate = date;
            _dob.text =
                "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
          });
        }
      },
      child: TextFormField(
        controller: _dob,
        enabled: false,
        decoration: const InputDecoration(
          labelText: "Date of Birth",
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(),
        ),
        validator: (v) => v == null || v.isEmpty ? "DOB required" : null,
      ),
    );
  }

  // ---------------- Submit ----------------

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<HealthProfileBloc>().add(
      OnUpdateHealthProfileEvent(
        heightCm: double.parse(_height.text),
        bloodGroup: _selectedBloodGroup,
        gender: _selectedGender,
        dateOfBirth:
            "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
      ),
    );
  }
}
