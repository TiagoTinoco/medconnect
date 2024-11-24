import 'package:flutter/material.dart';
import 'package:medconnect/configs/custom_colors.dart';
import 'package:medconnect/configs/snackbar_helper.dart';
import 'package:medconnect/controller/reminders_controller.dart';
import 'package:medconnect/controller/specialty_controller.dart';
import 'package:medconnect/controller/user_controller.dart';
import 'package:medconnect/views/components/custom_button_filled.dart';
import 'package:medconnect/views/components/custom_date_picker.dart';
import 'package:medconnect/views/components/custom_selected_field.dart';
import 'package:medconnect/views/components/custom_time_picker.dart';
import 'package:provider/provider.dart';

class ScheduleAppointmentPage extends StatefulWidget {
  const ScheduleAppointmentPage({super.key});

  static const routeName = '/schedule-appointment';

  @override
  State<ScheduleAppointmentPage> createState() => _ScheduleAppointmentPageState();
}

class _ScheduleAppointmentPageState extends State<ScheduleAppointmentPage> {
  late final _specialtyController = context.read<SpecialtyController>();
  late final _userController = context.read<UserController>();
  late final _reminderController = context.read<ReminderController>();

  Future<void> saveScheduleAppointment() async {
    await _reminderController.saveReminder(_userController.reminders);

    SnackbarHelper.showSnackbar(
      context: context,
      message: 'Salvo com sucesso!',
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: CustomColors.primary,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              'Agendar Consulta',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder(
                  future: _specialtyController.getSpecialties(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());

                    if (snapshot.hasError) return Center(child: Text("Erro: ${snapshot.error}"));

                    final List<String> specialtyNames = snapshot.data!.map((specialty) => specialty.name).toList();

                    return Column(
                      children: [
                        CustomSelectField(options: specialtyNames),
                        const SizedBox(height: 20),
                        const CustomTimePicker(),
                        const SizedBox(height: 20),
                        const CustomDatePicker(),
                        const SizedBox(height: 40),
                        CustomButtonFilled(
                          title: 'Salvar Consulta',
                          onPressed: () => saveScheduleAppointment(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
