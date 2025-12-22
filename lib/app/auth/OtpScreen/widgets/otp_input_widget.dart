import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpInputWidget extends StatefulWidget {
  final Function(String) onCompleted;
  final int length;
  final double fieldWidth;
  final double fieldHeight;

  const OtpInputWidget({
    super.key,
    required this.onCompleted,
    this.length = 4,
    this.fieldWidth = 60,
    this.fieldHeight = 60,
  });

  @override
  State<OtpInputWidget> createState() => _OtpInputWidgetState();
}

class _OtpInputWidgetState extends State<OtpInputWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (_) => TextEditingController(),
    );
    _focusNodes = List.generate(
      widget.length,
      (_) => FocusNode(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }

    // Check if all fields are filled
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == widget.length) {
      widget.onCompleted(otp);
    }
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.length, (index) {
        return Container(
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _focusNodes[index].hasFocus
                  ? colorScheme.primary
                  : isDark
                      ? colorScheme.onSurface.withOpacity(0.2)
                      : const Color(0xFFE5E7EB),
              width: 2,
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
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ) ?? TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: const InputDecoration(
              counterText: '',
              border: InputBorder.none,
            ),
            onChanged: (value) => _onChanged(value, index),
            onTap: () {
              if (_controllers[index].text.isNotEmpty) {
                _controllers[index].selection = TextSelection.fromPosition(
                  TextPosition(offset: _controllers[index].text.length),
                );
              }
            },
            onSubmitted: (_) {
              if (index < widget.length - 1) {
                _focusNodes[index + 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }
}