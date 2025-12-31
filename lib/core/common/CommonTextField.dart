import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final int maxLines;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool autocorrect;
  final bool enableSuggestions;
  final int? maxLength;
  final bool digitsOnly;

  const CommonTextField({
    super.key,
    required this.label,
    this.hintText,
     this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.focusNode,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.suffix,
    this.textInputAction = TextInputAction.next,
    this.style = const TextStyle(fontSize: 16.0),
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.onChanged,
    this.maxLength,
    this.digitsOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : maxLines,
      enabled: enabled,
      textInputAction: textInputAction,
      style: style,
      textAlign: textAlign,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      maxLength: maxLength,
      inputFormatters: digitsOnly
          ? [
              FilteringTextInputFormatter.digitsOnly,
              if (maxLength != null)
                LengthLimitingTextInputFormatter(maxLength),
            ]
          : null,

      decoration: InputDecoration(
        labelText: label,
        hintText: hintText?? 'Enter $label',
        labelStyle: const TextStyle(fontSize: 20),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefix: prefix,
        suffix: suffix,
        fillColor: Colors.white,
        // isDense: true,
        // contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
