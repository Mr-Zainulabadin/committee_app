import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kameti_app/utils/extensions.dart';

class AddKametiProvider extends ChangeNotifier {
  DateTime? _selectedStartDate;

  DateTime? get selectedStartDate => _selectedStartDate;

  DateTime? _selectedEndDate;

  DateTime? get selectedEndDate => _selectedEndDate;

  void setSelectedStartDate(DateTime date) {
    _selectedStartDate = date;
    notifyListeners();
  }

  void setSelectedEndDate(DateTime date) {
    _selectedEndDate = date;
    notifyListeners();
  }
}
