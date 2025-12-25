import 'package:medidropbox/app/dashboard/dashboard_widget/location.dart';
import 'package:medidropbox/app/models/profile/getprofile_model.dart';
import 'package:medidropbox/app/dashboard/tabs/profile/bloc/profile_bloc.dart';

import 'package:medidropbox/core/helpers/app_export.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  // Basic
  late TextEditingController fullNameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController phoneCtrl;
  late TextEditingController aadharCtrl;
  late TextEditingController abhaCtrl;

  // Address
  late TextEditingController address1Ctrl;
  late TextEditingController address2Ctrl;
  late TextEditingController cityCtrl;
  late TextEditingController stateCtrl;
  late TextEditingController countryCtrl;
  late TextEditingController pincodeCtrl;

  // Location (user friendly)
  late TextEditingController locationCtrl;
  double? selectedLat;
  double? selectedLng;

  // Emergency
  late TextEditingController ecNameCtrl;
  late TextEditingController ecPhoneCtrl;
  late TextEditingController ecRelationCtrl;
  late TextEditingController ecEmailCtrl;

  GerProfile? profile;

  @override
  void initState() {
    super.initState();

    profile = context.read<ProfileBloc>().state.profileData;

    fullNameCtrl = TextEditingController(text: profile?.fullName ?? "");
    emailCtrl = TextEditingController(text: profile?.email ?? "");
    phoneCtrl = TextEditingController(text: profile?.phone ?? "");
    aadharCtrl = TextEditingController(text: profile?.aadharId ?? "");
    abhaCtrl = TextEditingController(text: profile?.abhaId ?? "");

    address1Ctrl = TextEditingController(
      text: profile?.address?.addressLine1 ?? "",
    );
    address2Ctrl = TextEditingController(
      text: profile?.address?.addressLine2 ?? "",
    );
    cityCtrl = TextEditingController(text: profile?.address?.city ?? "");
    stateCtrl = TextEditingController(text: profile?.address?.state ?? "");
    countryCtrl = TextEditingController(text: profile?.address?.country ?? "");
    pincodeCtrl = TextEditingController(text: profile?.address?.pincode ?? "");

    locationCtrl = TextEditingController();
    selectedLat = profile?.address?.latitude;
    selectedLng = profile?.address?.longitude;

    if (selectedLat != null && selectedLng != null) {
      getAddressFromLatLng(
        selectedLat!,
        selectedLng!,
      ).then((value) => locationCtrl.text = value);
    }

    final ec = profile?.emergencyContacts?.isNotEmpty == true
        ? profile!.emergencyContacts!.first
        : null;

    ecNameCtrl = TextEditingController(text: ec?.personName ?? "");
    ecPhoneCtrl = TextEditingController(text: ec?.phone ?? "");
    ecRelationCtrl = TextEditingController(text: ec?.relationship ?? "");
    ecEmailCtrl = TextEditingController(text: ec?.email ?? "");
  }

  @override
  void dispose() {
    fullNameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    aadharCtrl.dispose();
    abhaCtrl.dispose();
    address1Ctrl.dispose();
    address2Ctrl.dispose();
    cityCtrl.dispose();
    stateCtrl.dispose();
    countryCtrl.dispose();
    pincodeCtrl.dispose();
    locationCtrl.dispose();
    ecNameCtrl.dispose();
    ecPhoneCtrl.dispose();
    ecRelationCtrl.dispose();
    ecEmailCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickLocation() async {
    // Future: Google map / place picker
    final lat = 19.0760;
    final lng = 72.8777;

    selectedLat = lat;
    selectedLng = lng;

    final address = await getAddressFromLatLng(lat, lng);
    locationCtrl.text = address;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        context.watch<ProfileBloc>().state.profileStatus == ApiStatus.loading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: isLoading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.check, color: Colors.green),
            onPressed: isLoading ? null : _onSubmit,
          ),
        ],
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.profileStatus == ApiStatus.success) {
            AppNavigators.pop();
          }
          if (state.profileStatus == ApiStatus.error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.mess)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      (profile?.profileImageUrl?.isNotEmpty == true
                              ? profile!.profileImageUrl!
                              : "https://i.pravatar.cc/150?img=3")
                          .toCircularImage(size: 100),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),

                _label("Full Name"),
                _inputField(controller: fullNameCtrl, hint: "Full name"),

                _label("Email"),
                _inputField(controller: emailCtrl, hint: "Email"),

                _label("Phone"),
                _inputField(controller: phoneCtrl, hint: "Phone"),

                _label("Aadhar ID"),
                _inputField(controller: aadharCtrl, hint: "Aadhar"),

                _label("ABHA ID"),
                _inputField(controller: abhaCtrl, hint: "ABHA"),

                const SizedBox(height: 20),
                _label("Address Line 1"),
                _inputField(controller: address1Ctrl, hint: "Address line 1"),

                _label("Address Line 2"),
                _inputField(controller: address2Ctrl, hint: "Address line 2"),

                _label("City"),
                _inputField(controller: cityCtrl, hint: "City"),

                _label("State"),
                _inputField(controller: stateCtrl, hint: "State"),

                _label("Country"),
                _inputField(controller: countryCtrl, hint: "Country"),

                _label("Pincode"),
                _inputField(controller: pincodeCtrl, hint: "Pincode"),

                _label("Location"),
                GestureDetector(
                  onTap: _pickLocation,
                  child: AbsorbPointer(
                    child: _inputField(
                      controller: locationCtrl,
                      hint: "Select location",
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                _label("Emergency Contact Name"),
                _inputField(controller: ecNameCtrl, hint: "Name"),

                _label("Emergency Phone"),
                _inputField(controller: ecPhoneCtrl, hint: "Phone"),

                _label("Relationship"),
                _inputField(controller: ecRelationCtrl, hint: "Relationship"),

                _label("Emergency Email"),
                _inputField(controller: ecEmailCtrl, hint: "Email"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final payload = {
      "fullName": fullNameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "aadharId": aadharCtrl.text.trim(),
      "abhaId": abhaCtrl.text.trim(),
      "address": {
        "addressLine1": address1Ctrl.text.trim(),
        "addressLine2": address2Ctrl.text.trim(),
        "city": cityCtrl.text.trim(),
        "state": stateCtrl.text.trim(),
        "country": countryCtrl.text.trim(),
        "pincode": pincodeCtrl.text.trim(),
        "latitude": selectedLat,
        "longitude": selectedLng,
      },
      "emergencyContacts": [
        {
          "personName": ecNameCtrl.text.trim(),
          "phone": ecPhoneCtrl.text.trim(),
          "relationship": ecRelationCtrl.text.trim(),
          "email": ecEmailCtrl.text.trim(),
          "isPrimary": true,
        },
      ],
    };

    context.read<ProfileBloc>().add(OnUpdateProfile(data: payload));
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _inputField({
    required String hint,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: const Color(0xffF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
