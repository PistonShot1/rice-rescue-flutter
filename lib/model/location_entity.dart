import 'package:equatable/equatable.dart';

class LocationData extends Equatable {
  final double? latitude;
  final double? longitude;

  LocationData({this.latitude, this.longitude});

  @override
  // TODO: implement props
  List<Object?> get props => [latitude, longitude];
}
