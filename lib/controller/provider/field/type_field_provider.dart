import 'package:flutter/material.dart';

class TypeFieldProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _listFilter = [
    {'filterTitle': 'All', 'filterColor': Colors.blue, 'filterStatus': true},
    {
      'filterTitle': 'Rainfed Lowland',
      'filterColor': Colors.orange,
      'filterStatus': false
    },
    {
      'filterTitle': 'Irrigated Lowland',
      'filterColor': Colors.yellow,
      'filterStatus': false
    },
    {
      'filterTitle': 'Upland',
      'filterColor': Colors.green,
      'filterStatus': false
    }
  ];

  List<Map<String, dynamic>> get listFilter => _listFilter;

  Map<String, dynamic> _selectedFilter = {
    'filterTitle': 'All',
    'filterColor': Colors.blue,
    'filterStatus': true
  };

  Map<String, dynamic> get selectedFilter => _selectedFilter;

  void selectType(Map<String, dynamic> filter) {
    _selectedFilter = filter;
    notifyListeners();
  }
}
