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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _selectedDate == null ? NoText(text: 'No Date Selected', noBg: true,) : Text(
                          'Date: ${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}',
                        ),
                      ),
                      CustomGui.textButton('Select date', () => _selectDate(context))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: _selectedTime == null ? NoText(text: 'No Time Selected', noBg: true,) : Text(
                          'Time: ${_selectedTime!.format(context)}',
                        ),
                      ),
                      CustomGui.textButton('Select time', () => _selectTime(context))
                    ],
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
                          //DEBUG:
                          // print('Event Name: ${_eventNameController.text}');
                          // print('Description: ${_descriptionController.text}');
                          // print('Location: ${_locationController.text}');
                          // print('Date: ${_selectedDate.toString()}');
                          // print('Time: ${_selectedTime.toString()}');
                          // print('Ticket Price: ${_ticketPriceController.text}');
                          // print('Is Family Oriented: $_isFamilyOriented');
                        }
                      }
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       EventDataModel event = EventDataModel(
                  //         title: _eventNameController.text,
                  //         description: _descriptionController.text,
                  //         location: _locationController.text,
                  //         date: _selectedDate.toString(),
                  //         time: _selectedTime!.format(context),
                  //         uid: FirebaseAuth.instance.currentUser?.uid,
                  //         ticketPrice: _ticketPriceController.text,
                  //         images: _selectedImages,
                  //         isFamilyOriented: _isFamilyOriented,
                  //       );
                  //       eventController.addEvent(event);
                  //       //DEBUG:
                  //       // print('Event Name: ${_eventNameController.text}');
                  //       // print('Description: ${_descriptionController.text}');
                  //       // print('Location: ${_locationController.text}');
                  //       // print('Date: ${_selectedDate.toString()}');
                  //       // print('Time: ${_selectedTime.toString()}');
                  //       // print('Ticket Price: ${_ticketPriceController.text}');
                  //       // print('Is Family Oriented: $_isFamilyOriented');
                  //     }
                  //   },
                  //   child: Text('Submit'),
                  // ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
