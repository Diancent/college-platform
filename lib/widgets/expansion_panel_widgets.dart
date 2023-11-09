import 'package:flutter/material.dart';

import '../models/ExpansionPanelItem.dart';

class ExpansionPanelItem {
  final String headerValue;
  final List<Widget> widgets;
  bool isExpanded;

  ExpansionPanelItem({
    required this.headerValue,
    required this.widgets,
    this.isExpanded = false,
  });
}

class ExpansionPanelWidgets extends StatefulWidget {
  final List<ExpansionPanelItem> items;

  ExpansionPanelWidgets({required this.items});

  @override
  _ExpansionPanelWidgetsState createState() => _ExpansionPanelWidgetsState();
}

class _ExpansionPanelWidgetsState extends State<ExpansionPanelWidgets> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.items[index].isExpanded = !isExpanded;
        });
      },
      children: widget.items.map<ExpansionPanel>((ExpansionPanelItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
          body: Column(
            children: item.widgets,
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
