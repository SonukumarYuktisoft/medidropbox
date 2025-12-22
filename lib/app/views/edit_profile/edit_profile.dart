import 'package:flutter/material.dart';
import 'package:medidropbox/core/extensions/image_extesion.dart';
import 'package:medidropbox/navigator/app_navigators/app_navigators.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () {
              AppNavigators.pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Profile Image
            Center(
              child: Stack(
                children: [
                  "https://i.pravatar.cc/150?img=3".toCircularImage(size: 100),
                  
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

            const SizedBox(height: 32),

            _label("Name"),
            _inputField(hint: "Charlotte king"),

            const SizedBox(height: 16),

            _label("E mail address"),
            _inputField(hint: "@johnkinggraphics.gmail.com"),

            const SizedBox(height: 16),

            _label("User name"),
            _inputField(hint: "@johnkinggraphics"),

            const SizedBox(height: 16),

            _label("Password"),
            _inputField(
              hint: "************",
              obscure: true,
              suffix: Icons.visibility_off,
            ),

            const SizedBox(height: 16),

            _label("Phone number"),
            _phoneField(),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _inputField({
    required String hint,
    bool obscure = false,
    IconData? suffix,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffix != null
            ? Icon(suffix, size: 20, color: Colors.grey)
            : null,
        filled: true,
        fillColor: const Color(0xffF5F5F5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }

  Widget _phoneField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Text("+91", style: TextStyle(color: Colors.grey)),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "6895312",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
