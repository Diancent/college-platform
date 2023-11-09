import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../lists/student_info.dart';

class WidgetDropdownMenu extends StatefulWidget {
  final List<Widget> items;

  const WidgetDropdownMenu({
    super.key,
    required this.items,
  });

  @override
  State<WidgetDropdownMenu> createState() => _WidgetDropdownMenuState();
}

class _WidgetDropdownMenuState extends State<WidgetDropdownMenu> {
  Widget? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<Widget>(
        value: widget.items.first,

        // icon: const Icon(Icons.arrow_downward),
        // iconSize: 25,
        // elevation: 8,
        isExpanded: true,
        onChanged: (Widget? newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: widget.items.map<DropdownMenuItem<Widget>>((Widget value) {
          return DropdownMenuItem<Widget>(
            value: value,
            child: value,
          );
        }).toList(),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          // width: 200,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 8,
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
      ),
    );
  }
}
