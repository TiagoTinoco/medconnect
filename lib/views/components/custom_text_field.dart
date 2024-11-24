import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medconnect/configs/custom_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.icon,
    this.readOnly = false,
    this.maxLength,
    this.minLines = 1,
    this.floatingLabelBehavior = FloatingLabelBehavior.auto,
    this.isSecret = false,
    this.initialValue,
    this.textInputType,
    this.controller,
    this.inputFormatters,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  final IconData? icon;
  final String label;
  final int? maxLength;
  final int minLines;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool readOnly;
  final bool isSecret;
  final String? initialValue;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        obscureText: isObscure,
        validator: widget.validator,
        onSaved: widget.onSaved,
        onChanged: widget.onChanged,
        keyboardType: widget.textInputType,
        maxLines: widget.minLines > 1 ? null : 1,
        maxLength: widget.maxLength,
        minLines: widget.minLines,
        style: TextStyle(color: widget.readOnly ? const Color(0xEF555555) : const Color(0xFF0F0F0F)),
        decoration: InputDecoration(
          isDense: true,
          labelText: widget.label,
          labelStyle: TextStyle(color: widget.readOnly ? const Color(0xEF555555) : const Color(0xFF0F0F0F)),
          contentPadding: const EdgeInsets.all(12),
          floatingLabelBehavior: widget.floatingLabelBehavior,
          focusColor: CustomColors.primary,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 1.5,
              color: CustomColors.primary,
            ),
          ),
          prefixIcon: widget.icon != null
              ? Icon(
                  widget.icon,
                  color: widget.readOnly ? const Color(0xEF555555) : const Color(0xFF0F0F0F),
                )
              : null,
          suffixIcon: widget.isSecret
              ? IconButton(
                  icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => isObscure = !isObscure),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
