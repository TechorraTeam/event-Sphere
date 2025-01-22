import 'package:flutter/material.dart';

class EventSphereRadioButton extends StatelessWidget {
  final List<String> options;
  final String title;
  final ValueNotifier<String>? selectedNotifier;
  final bool isBoolMode;
  final bool? initialSelection;
  final void Function(String)? onChanged;

  EventSphereRadioButton({
    super.key,
    required this.title,
    required this.options,
    this.selectedNotifier,
    this.isBoolMode = false,
    this.initialSelection,
    this.onChanged,
  }) : assert(
  (isBoolMode && initialSelection != null) || (!isBoolMode && selectedNotifier != null),
  'Provide either initialSelection (bool) or selectedNotifier (ValueNotifier<String>)',
  );

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> selectedValue =
    isBoolMode ? ValueNotifier<String>(options[initialSelection! ? 1 : 0]) : selectedNotifier!;

    return ValueListenableBuilder<String>(
      valueListenable: selectedValue,
      builder: (context, selected, child) {
        return Container(
          padding: EdgeInsets.only(left: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: options.map((option) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Radio<String>(
                          value: option,
                          groupValue: selected,
                          activeColor: Colors.deepOrange,
                          onChanged: (value) {
                            if (value != null) {
                              selectedValue.value = value;
                              onChanged?.call(value);
                            }
                          },
                        ),
                        Text(option),
                      ],
                    );
                  }).toList(),
                ),
              ],
            )
        );
      },
    );
  }
}
