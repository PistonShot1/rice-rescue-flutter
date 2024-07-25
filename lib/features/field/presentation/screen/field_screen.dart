import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_waveform_progressbar/simple_waveform_progressbar.dart';
import 'package:vhack_client/features/field/presentation/cubit/single_field/single_field_cubit.dart';
import 'package:vhack_client/presentation/components/button/icon_button.dart';
import 'package:vhack_client/presentation/components/button/icon_text_button.dart';
import 'package:vhack_client/presentation/components/card/user_avatar_card.dart';
import 'package:vhack_client/presentation/components/dialog/field/field_dialog.dart';
import 'package:vhack_client/presentation/components/image/mynetwork_image.dart';
import 'package:vhack_client/shared/constant/custom_appbar.dart';
import 'package:vhack_client/shared/constant/custom_color.dart';
import 'package:vhack_client/shared/constant/custom_snackbar.dart';
import 'package:vhack_client/shared/constant/custom_string.dart';
import 'package:vhack_client/shared/constant/custom_textstyle.dart';
import 'dart:ui' as ui;
import 'package:vhack_client/injection_container.dart' as di;
import '../../../../controller/service/location/location_service.dart';
import '../../domain/entity/field_entity.dart';

class FieldScreen extends StatefulWidget {
  final FieldEntity fieldEntity;
  const FieldScreen({super.key, required this.fieldEntity});

  @override
  State<FieldScreen> createState() => _FieldScreenState();
}

class _FieldScreenState extends State<FieldScreen> {
  Set<Marker> listMarker = {};
  List<LatLng> listPolyLine = [];
  List<LatLng> polylines = const [
    LatLng(3.221806, 101.725659),
    // LatLng(3.1588203, 101.5037507),
    // LatLng(2.9995464, 101.7030556),
    // LatLng(2.7569535, 101.6852335),
    // LatLng(3.167567, 101.7214351)
  ];
  List<LatLng> list1 = const [
    /* LatLng(3.222739685075595, 101.72409117221832),
    LatLng(3.222474901035788, 101.7242930084467),
    LatLng(3.2222897864891604, 101.72407139092684),
    LatLng(3.2225515578635036, 101.72387324273586)*/

    LatLng(3.554769650775009, 101.10064823180437),
    LatLng(3.554278077630511, 101.10082525759935),
    LatLng(3.554107415687913, 101.10050741583109),
    LatLng(3.5546652458812718, 101.10029853880405)
  ];
  LatLng? centerArea;
  LatLng tempPosition = const LatLng(3.5546531991620185, 101.10059626400471);
  LatLng pestPosition = const LatLng(3.5542195171635713, 101.10053423792124);
  BitmapDescriptor tempIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor pestIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor fieldIcon = BitmapDescriptor.defaultMarker;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  double pinPillPosition = -100;
  double zoom = 20;
  MarkerEntity? markerEntity;
  // LatLng currentLatLng = const LatLng(3.221806, 101.725659);
  LatLng currentLatLng = const LatLng(3.222961286835977, 101.72410760074854);
  LatLng paddyLatLng = const LatLng(2.9893830, 101.7138656);
  bool isPlay = false;
  //[LatLng(3.2227939139096318, 101.72411363571882), LatLng(3.2224755705277524, 101.72435335814953), LatLng(3.222334977204379, 101.72411162406206), LatLng(3.2226231934964162, 101.72390978783369)]
  //[LatLng(3.222326943299596, 101.72435101121664), LatLng(3.2220799006966545, 101.72451864928007), LatLng(3.2219737861726414, 101.72428261488676), LatLng(3.2222221677856058, 101.72414716333151)]

  @override
  void initState() {
    BlocProvider.of<SingleFieldCubit>(context)
        .getSingleField(fieldEntity: widget.fieldEntity);
    calculateCenter();
    setMarker();
    super.initState();
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  LatLng findCenter(List<LatLng> points) {
    // Calculate midpoints of sides
    LatLng midPoint1 = LatLng((points[0].latitude + points[1].latitude) / 2,
        (points[0].longitude + points[1].longitude) / 2);
    LatLng midPoint2 = LatLng((points[1].latitude + points[2].latitude) / 2,
        (points[1].longitude + points[2].longitude) / 2);

    // Calculate slopes of perpendicular bisectors
    double slope1 = -1 /
        ((points[1].longitude - points[0].longitude) /
            (points[1].latitude - points[0].latitude));
    double slope2 = -1 /
        ((points[2].longitude - points[1].longitude) /
            (points[2].latitude - points[1].latitude));

    // Calculate y-intercepts
    double yIntercept1 = midPoint1.longitude - slope1 * midPoint1.latitude;
    double yIntercept2 = midPoint2.longitude - slope2 * midPoint2.latitude;

    // Calculate center point
    double centerX = (yIntercept2 - yIntercept1) / (slope1 - slope2);
    double centerY = slope1 * centerX + yIntercept1;

    return LatLng(centerX, centerY);
  }

  void calculateCenter() {
    final center = findCenter(list1);
    setState(() {
      centerArea = center;
    });
    print('Center Points: ${center.latitude} ${center.longitude}');
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }

  void _handleMapTap(LatLng latLng) {
    setState(() {
      // listPolyLine.add(latLng);
      //_addMarker(latLng);
      pinPillPosition = -100;
    });

    print(listPolyLine);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> setMarker() async {
    final Uint8List pestBytes =
        await getBytesFromAsset('assets/field/pestdetector.png', 125);
    final Uint8List tempBytes =
        await getBytesFromAsset('assets/field/soiltempdetector.png', 125);
    final Uint8List fieldBytes =
        await getBytesFromAsset('assets/field/paddyXbg.png', 125);

    setState(() {
      pestIcon = BitmapDescriptor.fromBytes(pestBytes);
      tempIcon = BitmapDescriptor.fromBytes(tempBytes);
      fieldIcon = BitmapDescriptor.fromBytes(fieldBytes);
    });
  }

  void _addMarker(LatLng latLng) async {
    final Uint8List uint8list =
        await getBytesFromAsset('assets/resumegambar.jpg', 100);
    final markerID = MarkerId(latLng.toString());
    final marker = Marker(
        markerId: markerID,
        position: latLng,
        icon: BitmapDescriptor.fromBytes(uint8list),
        infoWindow: InfoWindow(title: 'Marker at $latLng'));
    listMarker.add(marker);
  }

  void _undo() {
    setState(() {
      if (listPolyLine.isNotEmpty && listMarker.isNotEmpty) {
        final lastMarker = listMarker.last;
        listPolyLine.removeAt(listPolyLine.length - 1);
        listMarker.remove(lastMarker);
      } else {
        SnackBarUtil.showSnackBar('Please draw at least 2 lines',
            CustomColor.getSecondaryColor(context));
      }
    });
  }

  void _handleMarkerTap(MarkerEntity marker) {
    setState(() {
      pinPillPosition = 10;
      zoom = 40;
      isPlay = false;
      markerEntity = MarkerEntity(
          markerIcon: marker.markerIcon,
          markerTitle: marker.markerTitle,
          latLng: marker.latLng);
    });
  }

  void showBottom() {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            SizedBox(
                width: double.maxFinite,
                height: 600,
                child: SingleChildScrollView(
                    child: FieldDialog(
                  fieldEntity: widget.fieldEntity,
                ))),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleFieldCubit, SingleFieldState>(
      builder: (context, state) {
        if (state is SingleFieldLoaded) {
          return Scaffold(
              backgroundColor: CustomColor.getBackgroundColor(context),
              appBar: buildAppBar(),
              floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
              floatingActionButton: buildFloatButton(),
              body: buildContent(state.fieldEntity.locationEntity!));
        }
        if (state is SingleFieldEmpty) {
          return buildErrorContent(state.emptyTitle);
        }
        if (state is SingleFieldFailure) {
          return buildErrorContent(state.failureTitle);
        }
        return Center(
          child: CircularProgressIndicator(
            color: CustomColor.getSecondaryColor(context),
          ),
        );
      },
    );
  }

  Widget buildErrorContent(String title) => Scaffold(
      backgroundColor: CustomColor.getBackgroundColor(context),
      appBar: buildAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: buildFloatButton(),
      body: Center(
        child: Text(
          title,
          style: CustomTextStyle.getTitleStyle(
              context, 21, CustomColor.getSecondaryColor(context)),
        ),
      ));

  Widget buildFloatButton() => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 100),
        child: FloatingActionButton(
          onPressed: () {
            showBottom();
          },
          child: const Icon(
            Icons.data_exploration,
            color: Colors.white,
          ),
        ),
      );

  Widget buildContent(List<LocationEntity> locations) => Stack(
        children: [buildGoogleMap(locations), buildAnimatedContainer()],
      );

  GoogleMap buildGoogleMap(List<LocationEntity> locations) {
    List<LatLng> listLocation = locations
        .map((location) => LatLng(location.lat, location.long))
        .toList();
    return GoogleMap(
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(target: paddyLatLng, zoom: zoom),
      onTap: _handleMapTap,
      polygons: <Polygon>{
        Polygon(
            polygonId: const PolygonId('_id'),
            points: listLocation,
            fillColor: Colors.blueAccent.withOpacity(0.2),
            strokeColor: Colors.blueAccent,
            geodesic: true,
            strokeWidth: 4),
      },
      markers: {
        Marker(
          markerId: const MarkerId('1'),
          position: findCenter(listLocation),
          icon: fieldIcon,
          infoWindow: const InfoWindow(title: 'Field 1'),
          onTap: () {
            final marker = MarkerEntity(
                markerIcon: 'assets/field/paddyXbg.png',
                markerTitle: 'Field 1 Location',
                latLng: findCenter(listLocation));
            _handleMarkerTap(marker);
          },
        ),
        Marker(
          markerId: const MarkerId('2'),
          position: LatLng(2.9893639, 101.7139538),
          icon: pestIcon,
          onTap: () {
            final marker = MarkerEntity(
                markerIcon: 'assets/field/pestdetector.png',
                markerTitle: 'Pest Detector Location',
                latLng: LatLng(2.9893639, 101.7139538));
            _handleMarkerTap(marker);
          },
        ),
        Marker(
          markerId: const MarkerId('3'),
          position: LatLng(2.9893830, 101.7138656),
          icon: tempIcon,
          onTap: () {
            final marker = MarkerEntity(
                markerIcon: 'assets/field/soiltempdetector.png',
                markerTitle: 'Soil Temp Detector Location',
                latLng: LatLng(2.9891861, 101.7138049));
            _handleMarkerTap(marker);
          },
        )
      },
      mapType: MapType.satellite,
    );
  }

  Widget buildAnimatedContainer() {
    if (markerEntity == null) {
      return Container();
    } else {
      return AnimatedPositioned(
        bottom: pinPillPosition,
        right: 0,
        left: 0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: buildAnimatedContainerCard()),
        ),
      );
    }
  }

  Widget buildAnimatedContainerCard() => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 20,
              color: Color(0x3F14181B),
              offset: Offset(0, 3),
            )
          ],
          borderRadius: BorderRadius.circular(64),
          color: CustomColor.getPrimaryColor(context)),
      child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(
            markerEntity!.markerIcon,
            fit: BoxFit.cover,
          ),
          title: Text(
            markerEntity!.markerTitle,
            style: CustomTextStyle.getTitleStyle(
                context, 15, CustomColor.getTertieryColor(context)),
          ),
          subtitle: markerEntity!.markerTitle == 'Pest Detector Location'
              ? SizedBox(
                  height: 30,
                  child: WaveformProgressbar(
                      color: Colors.grey, progressColor: Colors.greenAccent),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Latitude: ${markerEntity!.latLng.latitude}',
                      style: CustomTextStyle.getSubTitleStyle(
                          context, 12, CustomColor.getTertieryColor(context)),
                    ),
                    Text(
                      'Longitude: ${markerEntity!.latLng.longitude}',
                      style: CustomTextStyle.getSubTitleStyle(
                          context, 12, CustomColor.getTertieryColor(context)),
                    ),
                  ],
                ),
          trailing: buildTraling(markerEntity!)));

  Widget buildTraling(MarkerEntity markerEntity) {
    bool isPestDetector = markerEntity.markerTitle.contains('Field') ||
        markerEntity.markerTitle.contains('Soil Temp');

    return GestureDetector(
      onTap: () {
        setState(() {
          !isPestDetector ? isPlay = !isPlay : pinPillPosition = -100;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: CustomColor.getPrimaryColor(context)),
        child: Icon(
          !isPestDetector
              ? (isPlay ? Icons.pause : Icons.play_arrow)
              : Icons.close,
          size: 32,
          color: CustomColor.getSecondaryColor(context),
        ),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        backgroundColor: CustomColor.getSecondaryColor(context),
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text('Field',
            style: CustomTextStyle.getTitleStyle(
              context,
              18,
              CustomColor.getWhiteColor(context),
            )),
        actions: [
          IconButton(
              onPressed: () {
                _undo();
              },
              icon: Icon(
                Icons.undo,
                color: CustomColor.getWhiteColor(context),
              ))
        ],
      );
}

class MarkerEntity {
  final String markerIcon;
  final String markerTitle;
  final LatLng latLng;

  MarkerEntity(
      {required this.markerIcon,
      required this.markerTitle,
      required this.latLng});
}
