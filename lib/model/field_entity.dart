import 'package:google_maps_flutter/google_maps_flutter.dart';

class FieldEntity {
  final String fieldID;
  final String fieldColor;
  final String fieldLabel;
  final List<LatLng> fieldborderCoordinates;

  FieldEntity(
      {required this.fieldID,
      required this.fieldColor,
      required this.fieldLabel,
      required this.fieldborderCoordinates});

  Map<String, dynamic> toJson() {
    return {
      'id': fieldID,
      'color': fieldColor,
      'label': fieldLabel,
      'borderCoordinates': fieldborderCoordinates
          .map((latLng) =>
              {'latitude': latLng.latitude, 'longitude': latLng.longitude})
          .toList(),
    };
  }

  factory FieldEntity.fromJson(Map<String, dynamic> json) {
    return FieldEntity(
      fieldID: json['id'],
      fieldColor: json['color'],
      fieldLabel: json['label'],
      fieldborderCoordinates: (json['borderCoordinates'] as List<dynamic>)
          .map((coords) => LatLng(coords['latitude'], coords['longitude']))
          .toList(),
    );
  }
}
