import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:schedule/constants/constants.dart';
import 'package:schedule/src/controllers/schedule_controller.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:schedule/src/screens/schedule/widgets/color_palette.dart';
import 'package:schedule/src/screens/schedule/widgets/input_form.dart';
import 'package:schedule/src/widgets/close_button.dart';

class AddSchedule extends StatefulWidget {
  const AddSchedule({super.key});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final _formKey = GlobalKey<FormState>();

  final _title = TextEditingController();
  final _description = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('HH:mm').format(DateTime.now());
  String _endTime = DateFormat('HH:mm').format(DateTime.now());

  int _selectionRemind = 5;
  final List<int> _remindList = [5, 10, 15, 20, 25, 30];

  String _selectionRepeat = 'Nunca';
  final List<String> _repeatList = ['Nunca', 'Diariamente', 'Semanalmente', 'Mensalmente'];

  _save() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<ScheduleController>(context, listen: false);

    await provider.setSchedule(
      Schedule(
        id: 0,
        title: _title.text,
        description: _description.text,
        date: DateFormat.yMd('pt').format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectionRemind,
        repeat: _selectionRepeat,
        color: ColorPaletteState.selectedColor,
        isCompleted: 0,
      ),
    ).then((value) {
      Navigator.pop(context);
      notifier('Evento adicionado');
    });
  }

  _getDate() async {
    DateTime? pickerDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2050),
    );

    if (pickerDate != null) {
      setState(() => _selectedDate = pickerDate);
    }
  }

  _getTime(bool isStartTime) async {
    TimeOfDay? pickerTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1]),
      ),
    );

    if (pickerTime == null) return;
    if (!mounted) return;

    String formatedTime = pickerTime.format(context);

    if (isStartTime) {
      setState(() => _startTime = formatedTime);
    } else {
      setState(() => _endTime = formatedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Close()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cadastrar', style: headerTitle),
                  const ColorPalette(),
                ],
              ),
              InputForm(
                title: 'Título', 
                hint: 'Informe o título...', 
                controller: _title,
              ),
              InputForm(
                title: 'Descrição',
                hint: 'Informe a descrição...',
                controller: _description,
                maxLines: 4,
              ),
              InputForm(
                title: 'Data',
                hint: DateFormat.yMd('pt').format(_selectedDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _getDate(),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputForm(
                      title: 'Hora Inicial',
                      hint: _startTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _getTime(true),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  Expanded(
                    child: InputForm(
                      title: 'Hora Final',
                      hint: _endTime,
                      widget: IconButton(
                        icon: const Icon(Icons.access_time),
                        onPressed: () => _getTime(false),
                      ),
                    ),
                  ),
                ],
              ),
              InputForm(
                title: 'Lembrar',
                hint: '',
                widget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    value: _selectionRemind,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _remindList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text('$value minutos antes'),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectionRemind = value!),
                  ),
                ),
              ),
              InputForm(
                title: 'Repetir',
                hint: '',
                widget: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: DropdownButton(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    value: _selectionRepeat,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: _repeatList.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectionRepeat = value!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryClr,
        icon: const Icon(Icons.check, color: white),
        label: const Text('Salvar', style: TextStyle(color: white)),
        onPressed: () => _save(),
      ),
    );
  }
}