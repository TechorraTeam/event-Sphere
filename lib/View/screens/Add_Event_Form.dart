import 'dart:io';
import 'package:event_sphere/Widgets/Custom%20UI%20Button/custom_ui.dart';
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
  bool _isFamilyOriented = false;

  // List to store selected images
  List<String> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

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
    if (pickedFiles != null) {
      setState(() {
        // _selectedImages = pickedFiles.map((file) => File(file.path)).toList();
        _selectedImages = pickedFiles.map((file) => file.path).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: GetBuilder<EventController>(builder: (eventController) {
        return Padding(
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
                // Image Picker Button
                ElevatedButton(
                  onPressed: _pickImages,
                  child: Text('Pick Images'),
                ),
                SizedBox(height: 16.0),
                // Display previews of selected images
                _selectedImages.isNotEmpty
                    ? Container(
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
                )
                    : Text('No images selected'),
                SizedBox(height: 16.0),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : 'Date: ${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Select date'),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedTime == null
                            ? 'No time selected'
                            : 'Time: ${_selectedTime!.format(context)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _selectTime(context),
                      child: Text('Select time'),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                // Family Oriented Radio Button
                Row(
                  children: [
                    Text("Is this event family-oriented?"),
                    Radio<bool>(
                      value: true,
                      groupValue: _isFamilyOriented,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFamilyOriented = value!;
                        });
                      },
                    ),
                    Text("Yes"),
                    Radio<bool>(
                      value: false,
                      groupValue: _isFamilyOriented,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFamilyOriented = value!;
                        });
                      },
                    ),
                    Text("No"),
                  ],
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
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
                      print('Event Name: ${_eventNameController.text}');
                      print('Description: ${_descriptionController.text}');
                      print('Location: ${_locationController.text}');
                      print('Date: ${_selectedDate.toString()}');
                      print('Time: ${_selectedTime.toString()}');
                      print('Ticket Price: ${_ticketPriceController.text}');
                      print('Is Family Oriented: $_isFamilyOriented');
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
