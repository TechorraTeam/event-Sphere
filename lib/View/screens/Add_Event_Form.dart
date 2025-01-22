import 'dart:io';
import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
import 'package:event_sphere/Widgets/EventSphereRadioButton.dart';
import 'package:event_sphere/Widgets/NoText.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class AddEventForm extends StatefulWidget {
  const AddEventForm({super.key});

  @override
  _AddEventFormState createState() => _AddEventFormState();
}

class _AddEventFormState extends State<AddEventForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _ticketPriceController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final bool _isFamilyOriented = false;

  List<String> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();
  ValueNotifier<String> selectedGender = ValueNotifier<String>("Male");

  @override
  void initState() {
    super.initState();
    Get.put(EventController());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepOrange.shade300,
              onPrimary: Colors.white,
              onSurface: Colors.deepOrange,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepOrange,
                backgroundColor: Colors.deepOrange.shade50
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepOrange.shade300,
              onPrimary: Colors.white,
              onSurface: Colors.deepOrange,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepOrange,
                backgroundColor: Colors.deepOrange.shade50,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }


  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    setState(() {
      // _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
      _selectedImages = pickedFiles.map((file) => file.path).toList();
    });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
        backgroundColor: Colors.deepOrange.shade50,
      ),
      backgroundColor: Colors.deepOrange.shade50,
      body: GetBuilder<EventController>(builder: (eventController) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomGui.textField(_eventNameController, 'Event Name'),
                  SizedBox(height: 16.0),
                  CustomGui.textField(_descriptionController, 'Description'),
                  SizedBox(height: 16.0),
                  CustomGui.textField(_locationController, 'Location'),
                  SizedBox(height: 16.0),
                  CustomGui.textField(_ticketPriceController, 'Ticket Price'),
                  SizedBox(height: 16.0),
                  CustomGui.secondaryButton('Pick Images', _pickImages),
                  SizedBox(height: 16.0),
                  _selectedImages.isNotEmpty
                      ? SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.file(
                                File(_selectedImages[index]),
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                        ) : NoText(text: 'No Images Selected'),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.only(right: 23, top: 7, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: _selectedDate == null ? Colors.transparent : Colors.deepOrange,
                            width: 2
                        )
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _selectedDate == null ? NoText(text: 'No Date Selected', noBg: true,) : Container(
                            padding: EdgeInsets.only(left: 23),
                            child: Text(
                              DateFormat('MMMM dd, yyyy').format(_selectedDate!), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange
                            ),),
                          ),
                        ),
                        CustomGui.textButton('Select date', () => _selectDate(context))
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(right: 23, top: 7, bottom: 7),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: _selectedTime == null ? Colors.transparent : Colors.deepOrange,
                          width: 2
                        )
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _selectedTime == null ? NoText(text: 'No Time Selected', noBg: true,) : Container(
                            padding: EdgeInsets.only(left: 23),
                            child: Text(
                              _selectedTime!.format(context), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange
                            ),),
                          ),
                        ),
                        CustomGui.textButton('Select time', () => _selectTime(context))
                      ],
                    ),
                  ),
                  SizedBox(height: 16.0),
                  EventSphereRadioButton(
                    title: "Is Family Oriented?",
                    options: ['Yes', 'No'],
                    isBoolMode: true,
                    initialSelection: true,
                    onChanged: (value) {
                      print('Selected: $value');
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomGui.primaryButton(
                      "Submit",
                          () {
                        if (_formKey.currentState!.validate()) {
                          EventDataModel event = EventDataModel(
                            title: _eventNameController.text,
                            description: _descriptionController.text,
                            location: _locationController.text,
                            date: _selectedDate.toString(),
                            time: _selectedTime!.format(context),
                            uid: FirebaseAuth.instance.currentUser?.uid,
                            ticketPrice: _ticketPriceController.text,
                            images: _selectedImages,
                            isFamilyOriented: _isFamilyOriented,
                          );
                          eventController.addEvent(event);
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
