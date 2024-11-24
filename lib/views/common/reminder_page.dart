import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/controller/reminders_controller.dart';
import 'package:medconnect/model/reminder_model.dart';
import 'package:provider/provider.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    late final reminderController = context.read<ReminderController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Lembretes...',
          style: TextStyle(
            fontSize: 18,
            color: CustomColors.primary,
          ),
        ),
        StreamBuilder<DocumentSnapshot>(
          stream: reminderController.getReminders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

            if (snapshot.hasError) return const Center(child: Text('Erro ao carregar os lembretes.'));

            if (!snapshot.hasData || !snapshot.data!.exists) return const Center(child: Text('Nenhum dado encontrado.'));

            List<dynamic> remindersData = snapshot.data!['reminders'] ?? [];

            if (remindersData.isEmpty) return const Center(child: Text('Nenhum lembrete encontrado.'));

            final reminders = remindersData.map((reminder) {
              return ReminderModel.fromMap(reminder as Map<String, dynamic>);
            }).toList();

            return ListView.builder(
              shrinkWrap: true,
              itemCount: reminders.length,
              itemBuilder: (context, index) {
                return ConsultationReminder(
                  specialtie: reminders[index].specialtieName,
                  hoursTime: reminders[index].hoursTime,
                  dateTime: reminders[index].dateTime,
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ConsultationReminder extends StatelessWidget {
  const ConsultationReminder({
    super.key,
    required this.specialtie,
    required this.dateTime,
    required this.hoursTime,
  });

  final String specialtie;
  final String dateTime;
  final String hoursTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Agenda',
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColors.secondary,
                  ),
                ),
                Text(
                  'Data: $dateTime',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  specialtie,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: CustomColors.primary,
                  ),
                ),
                Text(
                  'Às $hoursTime',
                  style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
