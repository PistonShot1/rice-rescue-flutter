import 'package:flutter/material.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

class MetricProvider extends ChangeNotifier {
  String _cropNutrient = '';
  String get cropNutrient => _cropNutrient;

  FieldEntity? _selectedField;
  FieldEntity? get selectedField => _selectedField;

  void setNutrientHome(String value) {
    _cropNutrient = value;
    notifyListeners();
  }

  void setSelectedField(FieldEntity value) {
    _selectedField = value;
    notifyListeners();
  }
}
