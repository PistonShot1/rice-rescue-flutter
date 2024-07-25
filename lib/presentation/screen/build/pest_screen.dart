import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vhack_client/presentation/components/button/text_button.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';

import '../../../controller/service/location/location_service.dart';
import '../../../model/field_entity.dart';

class PestScreen extends StatefulWidget {
  const PestScreen({super.key});

  @override
  State<PestScreen> createState() => _PestScreenState();
}

class _PestScreenState extends State<PestScreen> {
  double currentLatitude = 0.0;
  double currentLongitude = 0.0;
  List<FieldEntity> fields = [];
  List<LatLng> currentPolyline = [];
  Color currentPolylineColor = Colors.red;
  GoogleMapController? mapController;
  final tcLt = TextEditingController();
  final tcLg = TextEditingController();

  Future<void> getCurrentLocation() async {
    final location = LocationService.currentLocation();
    await location.then((value) {
      debugPrint('Curent Latitude ${value.latitude}');
      debugPrint('Current Longitude ${value.longitude}');
      setState(() {
        currentLatitude = value.latitude;
        currentLongitude = value.longitude;
      });
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    getCurrentLocation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(3.00, 1.00),
          zoom: 10.0,
        ),
        onTap: _handleMapTap,
        polylines: _getPolyLines(),
        mapType: MapType.normal,
        markers: _getMarkers(),
        zoomGesturesEnabled: true,
        tiltGesturesEnabled: false,
        onCameraMove: (position) {
          print(position.zoom);
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => _handleMapLongPress(),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Set<Polyline> _getPolyLines() {
    Set<Polyline> polylines = fields.map((field) {
      return Polyline(
          polylineId: PolylineId(field.fieldID),
          points: field.fieldborderCoordinates,
          color: Color(int.parse(field.fieldColor)),
          width: 2);
    }).toSet();
    if (currentPolyline.isNotEmpty) {
      polylines.add(Polyline(
          polylineId: PolylineId('currentPolyline'),
          points: currentPolyline,
          color: currentPolylineColor,
          width: 2));
    }
    return polylines;
  }

  Set<Marker> _getMarkers() {
    return fields.map((field) {
      return Marker(
        markerId: MarkerId(field.fieldID),
        position: field.fieldborderCoordinates[
            0], // You can adjust this to position the label marker
        infoWindow: InfoWindow(
          title: field.fieldLabel,
          snippet: 'Geofenced Area',
        ),
      );
    }).toSet();
  }

  void _handleMapTap(LatLng latLng) {
    setState(() {
      currentPolyline.add(latLng);
    });
  }

  void _handleMapLongPress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Name for Geofenced Area:'),
          content: Column(
            children: [
              TextField(
                controller: tcLt,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Latitude'),
              ),
              TextField(
                controller: tcLg,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Longitude'),
              )
            ],
          ),
          actions: <Widget>[
            TextOnlyButton(
                buttonTitle: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                isMain: false,
                borderRadius: 12),
            TextOnlyButton(
                buttonTitle: 'Save',
                onPressed: () {
                  currentPolyline.add(
                      LatLng(double.parse(tcLt.text), double.parse(tcLg.text)));
                  setState(() {
                    fields.add(FieldEntity(
                      fieldID: UniqueKey().toString(),
                      fieldLabel: 'Field ${fields.length + 1}',
                      fieldColor: currentPolylineColor.value.toString(),
                      fieldborderCoordinates: List.from(currentPolyline),
                    ));
                    // currentPolyline.clear();
                  });
                  Navigator.of(context).pop();
                },
                isMain: true,
                borderRadius: 12)
          ],
        );
      },
    );
  }
}
