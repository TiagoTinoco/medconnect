import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/controller/reminders_controller.dart';
import 'package:provider/provider.dart';
import 'package:select_field/select_field.dart';

class CustomSelectField extends StatelessWidget {
  const CustomSelectField({
    super.key,
    required this.options,
  });

  final List<String> options;

  @override
  Widget build(BuildContext context) {
    late final reminderController = context.read<ReminderController>();
    final optionsController = options.map((specialties) => Option(label: specialties, value: specialties)).toList();

    return SelectField<String>(
      options: optionsController,
      initialOption: Option<String>(
        label: '',
        value: '',
      ),
      menuPosition: MenuPosition.below,
      onTextChanged: (value) => reminderController.name = value,
      inputStyle: const TextStyle(),
      menuDecoration: MenuDecoration(
        margin: const EdgeInsets.only(top: 8),
        height: 210,
        alignment: MenuAlignment.center,
        backgroundDecoration: BoxDecoration(
          color: CustomColors.secondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 3,
            ),
          ],
        ),
        animationDuration: const Duration(milliseconds: 400),
        buttonStyle: TextButton.styleFrom(
          fixedSize: const Size(double.infinity, 60),
          backgroundColor: CustomColors.primary,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: CustomColors.secondary,
          ),
        ),
        separatorBuilder: (context, index) => Container(
          height: 1,
          width: double.infinity,
          color: CustomColors.primary,
        ),
      ),
    );
  }
}
