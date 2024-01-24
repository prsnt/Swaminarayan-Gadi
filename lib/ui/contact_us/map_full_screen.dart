import 'dart:async';

import 'package:appstructure/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapFullScreen extends StatefulWidget {
  const MapFullScreen({Key? key}) : super(key: key);

  @override
  _MapFullScreenState createState() => _MapFullScreenState();
}

class _MapFullScreenState extends State<MapFullScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.996358854281564, 72.61075245780286),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    _markers.add(const Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(22.996358854281564, 72.61075245780286),
        infoWindow: InfoWindow(title: 'Shree Swaminarayan Mandir Maninagar')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBarCustom(
              title: 'contact_us'.tr,
              isBack: true,
              isFilter: false,
              isSearch: false,
              backCallback: () {
                Navigator.of(context).pop(true);
              },
              filterCallBack: () {},
              searchCallBack: () {},
            ),
            Expanded(
                child: GoogleMap(
              mapType: MapType.normal,
              buildingsEnabled: true,
              indoorViewEnabled: true,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              initialCameraPosition: _kGooglePlex,
              markers: Set<Marker>.of(_markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ))
          ],
        ),
      ),
    );
  }
}
