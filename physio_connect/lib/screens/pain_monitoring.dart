import 'package:flutter/material.dart';
import '../utils/storage_helper.dart';

class PainMonitoringPage extends StatefulWidget {

  @override
  _PainMonitoringPageState createState() => _PainMonitoringPageState();
}

class _PainMonitoringPageState extends State<PainMonitoringPage> {
  int _painLevel = 5;
  String _painLocation = '';
  List<Map<String, dynamic>> _painHistory = [];