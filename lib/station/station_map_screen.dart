import 'dart:async';

import 'package:fix_fill/Controller/shop_controller.dart';
import 'package:fix_fill/user/checkout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

class StationLocationPickerScreen extends StatefulWidget {

  String stationId;
bool station;

  StationLocationPickerScreen({required this.stationId, required this.station});

  @override
  _StationLocationPickerScreenState createState() => _StationLocationPickerScreenState();
}


class _StationLocationPickerScreenState extends State<StationLocationPickerScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;
  String location2='';
  // =========================================

  loc.Location location= loc.Location();
  late String stationAddress = '';
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;
    loc.LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }



    _locationData = await location.getLocation();
    _lastMapPosition = LatLng(_locationData.latitude!, _locationData.longitude!);
    print("Locationnnnnn: ${_lastMapPosition}");
    if (_controller.isCompleted) {
      final GoogleMapController mapController = await _controller.future;
      mapController.animateCamera(CameraUpdate.newLatLng(_lastMapPosition));
    }

    setState(() {});
  }



  // ==========================================
  var controller =Get.put(ShopController());

  void _onMapTapped(LatLng location) {

    setState(() {
      getAddressFromLatLng(location.latitude, location.longitude).then((address) {
        setState(() {
          stationAddress = address;
          print(stationAddress);
        });
      });

      _markers.clear(); // Clear existing markers
      _lastMapPosition = location; // Update the last map position
      _markers.add(Marker(
        markerId: MarkerId(location.toString()),
        position: location,
        infoWindow: InfoWindow(
          title: 'Selected Location',
          snippet: '${location.latitude}, ${location.longitude}',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return "${place.street}, ${place.locality}, ${place.country}";
      }
      return "Unknown location please see Map";
    } catch (e) {
      print("Error fetching address: $e");
      return "Error fetching address";
    }
  }



  @override
  Widget build(BuildContext context) {
    print(_markers);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map for Station'),
          // backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _lastMapPosition??_center,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onTap:_onMapTapped,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    SizedBox(height:20.h),

                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0.h),


                  ],
                ),
              ),

            ),
          Padding(

              padding: EdgeInsets.all(16.0.h),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                   Text("Please Select location for Station",style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.0.h),

                  ],
                ),
              ),

            ),
            _markers.isEmpty?
            Container():
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:  EdgeInsets.all(16.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // Align the content at the bottom
                  children: [

                    (stationAddress!="")
                        ?(Text(
                      "Address is: ${stationAddress}"

                    )

                    )
                        :(
                    Container()
                    ),


                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        ShopController.instance.shopSavelocation(_lastMapPosition, widget.stationId, widget.station);
                      },
                      child: Text("Continue"),
                    ),
                    SizedBox(height: 16.0.h),
                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}