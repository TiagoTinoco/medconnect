import 'package:flutter/material.dart';
import 'package:medconnect/controller/reminders_controller.dart';
import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:provider/provider.dart';

class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({super.key});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late final reminderController = context.read<ReminderController>();
  TimeOfDay? _selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      reminderController.hoursTime = picked.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _selectedTime == null ? 'Nenhum horário selecionado' : 'Horário selecionado: ${_selectedTime!.format(context)}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          CustomButtonBorder(
            title: 'Escolher Horário',
            onPressed: () => _selectTime(context),
          ),
        ],
      ),
    );
  }
}
