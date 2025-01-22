import 'package:event_sphere/Resources/Images/assets_images.dart';
import 'package:event_sphere/View/screens/Events_Screen.dart';
import 'package:event_sphere/controller/event_controller.dart';
import 'package:event_sphere/model/event_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../View/screens/Event_Detail_Screen.dart';

class CustomGui {
  static Widget customButton(String text, Function() onPressed) {
    return Container(
        height: 45.h,
        width: 280.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            elevation: 3, // Shadow elevation
            padding:
                EdgeInsets.symmetric(horizontal: 50, vertical: 10), // Padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0), // Rounded corners
            ),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  static Widget customFormField(String labelText, String validatorText,
      bool isPasswordType, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Color(0x000000),
          ),
        ),
      ),
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      validator: (value) {
        if (value == null) {
          return validatorText;
        }
        return null;
      },
    );
  }

  static Widget textField(TextEditingController controller, String text) {
    return SizedBox(
        height: 45.h,
        width: 280.w,
        child: TextFormField(
          controller: controller,
          style: TextStyle(
            color: Colors.deepOrange.shade900,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none
          ),
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.deepOrange,
            ),
            hintText: 'Enter your $text',
            hintStyle: TextStyle(
              color: Colors.deepOrange.shade300,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.deepOrange,
                width: 2,
              ),
            ),
          ),
        ));
  }

  static Widget genderRadio(ValueNotifier<String> selectedGender) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedGender,
      builder: (context, value, child) {
        return Row(
          children: [
            Radio<String>(
              value: "Male",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Male"),
            Radio<String>(
              value: "Female",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Female"),
            Radio<String>(
              value: "Other",
              groupValue: value,
              onChanged: (newValue) {
                selectedGender.value = newValue!;
              },
            ),
            Text("Other"),
          ],
        );
      },
    );
  }

  static showingEventsCard(EventController controller) {
    return FutureBuilder<List<EventDataModel>>(
      future: controller.getAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No events available'));
        } else {
          final events = snapshot.data!;
          return Padding(
            padding: EdgeInsets.all(13),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => SizedBox(
                height: 7,
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    Get.to(EventDetailScreen(
                      eventId: events[index].id ?? "",
                    ))
                  },
                  child: Card(
                    elevation: 7,
                    color: Colors.white,
                    child: ListTile(
                      trailing: Container(
                        width: 40,
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 250, 222, 225),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Text(
                              formatDateString(events[index].date ?? "")
                                  .split(' ')[0],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              formatDateString(events[index].date ?? "")
                                  .split(' ')[1]
                                  .replaceAll(',', ''),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      leading: Container(
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(AssetsImages.chinaTownImage),
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            events[index].title?.capitalize ?? "",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.location_pin, color: Colors.grey),
                              Text(
                                events[index].location?.capitalize ?? "",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  static final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static Widget primaryButton(String name, Function()? onPressed,
      {bool isDisabled = false}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.blueGrey : Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        name,
        style: isDisabled ? TextStyle(color: Colors.deepOrange) :TextStyle(color: Colors.deepOrange.shade500),
      ),
    );
  }

  static Widget secondaryButton(String name, Function()? onPressed,
      {bool isDisabled = false}){
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? Colors.blueGrey : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: Colors.deepOrange,
            width: 2
          )
        ),
      ),
      child: Text(
        name,
        style: isDisabled ? TextStyle(color: Colors.deepOrange) : TextStyle(color: Colors.deepOrange),
      ),
    );
  }

  static Widget textButton(String name, Function()? onPressed,
      {bool isDisabled = false}){
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.deepOrange.shade900,
        backgroundColor: Colors.deepOrange.shade100,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}
