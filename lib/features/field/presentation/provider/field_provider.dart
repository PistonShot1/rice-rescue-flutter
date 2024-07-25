import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vhack_client/features/field/domain/entity/field_entity.dart';

class FieldProvider extends ChangeNotifier {
  final List<LatLng> _listLocation = [];

  List<LatLng> get listLocation => _listLocation;

  void resetLocation() {
    _listLocation.clear();
    notifyListeners();
  }

  void addLocation(LocationEntity locationEntity) {
    _listLocation.add(LatLng(locationEntity.lat, locationEntity.long));
    notifyListeners();
  }

  void removeLocation(int index) {
    if (_listLocation.isEmpty || index < 0 || index >= _listLocation.length) {
      debugPrint('Invalid index or empty list');
    } else {
      _listLocation.removeAt(index);
    }
    notifyListeners();
    print('Locations: ${_listLocation.length}');
  }
}
