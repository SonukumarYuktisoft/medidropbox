import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/core/extensions/space_extension.dart';
import 'package:medidropbox/core/validator/validator_helper.dart';

class EmergencyContactWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onContactChanged;
  final Map<String, dynamic>? initialData;

  const EmergencyContactWidget({
    super.key,
    required this.onContactChanged,
    this.initialData,
  });

  @override
  State<EmergencyContactWidget> createState() => _EmergencyContactWidgetState();
}

class _EmergencyContactWidgetState extends State<EmergencyContactWidget> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _relationshipController = TextEditingController();
  bool _isPrimary = true;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _nameController.text = widget.initialData!['personName'] ?? '';
      _phoneController.text = widget.initialData!['phone'] ?? '';
      _emailController.text = widget.initialData!['email'] ?? '';
      _relationshipController.text = widget.initialData!['relationship'] ?? '';
      _isPrimary = widget.initialData!['isPrimary'] ?? true;
    }

    _nameController.addListener(_notifyChanges);
    _phoneController.addListener(_notifyChanges);
    _emailController.addListener(_notifyChanges);
    _relationshipController.addListener(_notifyChanges);
  }

  void _notifyChanges() {
    widget.onContactChanged({
      'personName': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'relationship': _relationshipController.text,
      'isPrimary': _isPrimary,
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _relationshipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? colorScheme.onSurface.withOpacity(0.2)
              : const Color(0xFFE5E7EB),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Emergency Contact',
                style:
                    textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ) ??
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    'Primary',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Switch(
                    value: _isPrimary,
                    onChanged: (value) {
                      setState(() {
                        _isPrimary = value;
                      });
                      _notifyChanges();
                    },
                    activeColor: colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
          16.heightBox,
          CommonTextField(
            controller: _nameController,
            label: 'Contact Name',
            hintText: 'Enter contact name',
            prefixIcon: Icon(
              FontAwesomeIcons.user,
              color: colorScheme.primary.withOpacity(0.7),
            ),
            validator: ValidatorHelper.isValidUsername,
          ),
          16.heightBox,
          CommonTextField(
            controller: _phoneController,
            label: 'Contact Phone',
            hintText: '+91 0000 0000 00',
            prefixIcon: Icon(
              FontAwesomeIcons.phone,
              color: colorScheme.primary.withOpacity(0.7),
            ),
            keyboardType: TextInputType.phone,
            digitsOnly: true,
            maxLength: 10,
            validator: ValidatorHelper.isValidPhoneNumber,
          ),
          16.heightBox,
          CommonTextField(
            controller: _emailController,
            label: 'Contact Email',
            hintText: 'contact@example.com',
            prefixIcon: Icon(
              FontAwesomeIcons.envelope,
              color: colorScheme.primary.withOpacity(0.7),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: ValidatorHelper.isValidEmail,
          ),
          16.heightBox,
          CommonTextField(
            controller: _relationshipController,
            label: 'Relationship',
            hintText: 'e.g., Spouse, Parent, Sibling',
            prefixIcon: Icon(
              FontAwesomeIcons.userGroup,
              color: colorScheme.primary.withOpacity(0.7),
            ),
            validator: (value) =>
                ValidatorHelper.required(value, fieldName: "relationship"),
          ),
        ],
      ),
    );
  }
}
