import 'package:flutter/material.dart';

class ExpansionPanelItemModel {
  final String headerValue;
  final List<Widget> widgets;

  ExpansionPanelItemModel({
    required this.headerValue,
    required this.widgets,
  });
}
