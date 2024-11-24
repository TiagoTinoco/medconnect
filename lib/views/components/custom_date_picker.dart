import 'package:flutter/material.dart';
import 'package:medconnect/controller/reminders_controller.dart';
import 'package:medconnect/views/components/custom_button_border.dart';
import 'package:provider/provider.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late final reminderController = context.read<ReminderController>();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate.add(const Duration(days: 1)),
      firstDate: currentDate.add(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      final dateTime = '${picked.day}/${picked.month}/${picked.year}';

      reminderController.dateTime = dateTime;
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
            _selectedDate == null ? 'Nenhuma data selecionada' : 'Data selecionada: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          CustomButtonBorder(
            title: 'Escolher Horário',
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }
}
