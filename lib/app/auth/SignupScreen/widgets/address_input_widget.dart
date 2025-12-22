import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medidropbox/core/common/CommonTextField.dart';
import 'package:medidropbox/core/extensions/space_extension.dart';
import 'package:medidropbox/core/helpers/app_export.dart' as Validators;
import 'package:medidropbox/core/validator/validator_helper.dart';

class AddressInputWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onAddressChanged;
  final Map<String, dynamic>? initialData;

  const AddressInputWidget({
    super.key,
    required this.onAddressChanged,
    this.initialData,
  });

  @override
  State<AddressInputWidget> createState() => _AddressInputWidgetState();
}

class _AddressInputWidgetState extends State<AddressInputWidget> {
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _pincodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _addressLine1Controller.text = widget.initialData!['addressLine1'] ?? '';
      _addressLine2Controller.text = widget.initialData!['addressLine2'] ?? '';
      _cityController.text = widget.initialData!['city'] ?? '';
      _stateController.text = widget.initialData!['state'] ?? '';
      _countryController.text = widget.initialData!['country'] ?? '';
      _pincodeController.text = widget.initialData!['pincode'] ?? '';
    }

    _addressLine1Controller.addListener(_notifyChanges);
    _addressLine2Controller.addListener(_notifyChanges);
    _cityController.addListener(_notifyChanges);
    _stateController.addListener(_notifyChanges);
    _countryController.addListener(_notifyChanges);
    _pincodeController.addListener(_notifyChanges);
  }

  void _notifyChanges() {
    widget.onAddressChanged({
      'addressLine1': _addressLine1Controller.text,
      'addressLine2': _addressLine2Controller.text,
      'city': _cityController.text,
      'state': _stateController.text,
      'country': _countryController.text,
      'pincode': _pincodeController.text,
    });
  }

  @override
  void dispose() {
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Address Details',
          style:
              textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ) ??
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        16.heightBox,
        CommonTextField(
          controller: _addressLine1Controller,
          label: 'Address Line 1',
          hintText: '123 Main Street',
          prefixIcon: Icon(
            FontAwesomeIcons.locationDot,
            color: colorScheme.primary.withOpacity(0.7),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter address line 1';
            }
            return null;
          },
        ),
        16.heightBox,
        CommonTextField(
          controller: _addressLine2Controller,
          label: 'Address Line 2',
          hintText: 'Apartment 4B (Optional)',
          prefixIcon: Icon(
            FontAwesomeIcons.building,
            color: colorScheme.primary.withOpacity(0.7),
          ),
        ),
        16.heightBox,
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                controller: _cityController,
                label: 'City',
                hintText: 'Mumbai',
                prefixIcon: Icon(
                  FontAwesomeIcons.city,
                  color: colorScheme.primary.withOpacity(0.7),
                ),
                validator: (value) =>
                    ValidatorHelper.required(value, fieldName: "city"),
              ),
            ),
            12.heightBox,
            Expanded(
              child: CommonTextField(
                controller: _stateController,
                label: 'State',
                hintText: 'Maharashtra',
                prefixIcon: Icon(
                  FontAwesomeIcons.map,
                  color: colorScheme.primary.withOpacity(0.7),
                ),
                validator: (value) =>
                    ValidatorHelper.required(value, fieldName: "state"),
              ),
            ),
          ],
        ),
        16.heightBox,
        Row(
          children: [
            Expanded(
              child: CommonTextField(
                controller: _countryController,
                label: 'Country',
                hintText: 'India',
                prefixIcon: Icon(
                  FontAwesomeIcons.globe,
                  color: colorScheme.primary.withOpacity(0.7),
                ),
                validator: (value) =>
                    ValidatorHelper.required(value, fieldName: "country"),
              ),
            ),
            12.heightBox,
            Expanded(
              child: CommonTextField(
                controller: _pincodeController,
                label: 'Pincode',
                hintText: '400001',
                prefixIcon: Icon(
                  FontAwesomeIcons.mailBulk,
                  color: colorScheme.primary.withOpacity(0.7),
                ),
                keyboardType: TextInputType.number,
                digitsOnly: true,
                maxLength: 6,
                validator: ValidatorHelper.isValidPincode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
