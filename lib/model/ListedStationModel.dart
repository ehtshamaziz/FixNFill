import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ListStationModel {

  String id;
  String name;
  double latitude;
  double longitude;
  double? distance;
  String status;
  String? imageURL;
  String? imageProfileURL;
  String? description;



  ListStationModel({required this.id,required this.name,required this.latitude,required this.longitude, this.distance, required this.status, this.imageURL, this.imageProfileURL, this.description});



  double calculateDistance(LatLng start, LatLng end) {
    var dLat = _degreesToRadians(end.latitude - start.latitude);
    var dLon = _degreesToRadians(end.longitude - start.longitude);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(start.latitude)) * cos(_degreesToRadians(end.latitude)) *
            sin(dLon / 2) * sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    const double radius = 6371; // Earth's radius in kilometers
    return radius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }

  double distanceTo(LatLng otherLocation) {
    print("Lat other ${this.latitude}");
    print("Long other ${this.longitude}");
    print("Other location: ${otherLocation}");
    // Use the same calculateDistance method as described in the previous response
    print("Location in distance ${calculateDistance(LatLng(this.latitude, this.longitude), otherLocation)}");
    return calculateDistance(LatLng(this.latitude, this.longitude), otherLocation);

  }
}

class Service {
bool fuel;
  String id;
  String category;
  double price;
  int quantity;
int counter;
bool inNotAvailable;
  Service({required this.fuel,required this.id,  required this.category, required this.price, required this.quantity,required this.counter, required this.inNotAvailable});

  factory Service.fromSnapshot(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Service(
      id: doc.id,
      inNotAvailable:false,
      fuel:data['fuel'],
      category: data['category'],
      price: data['price'].toDouble(),
      quantity: data['quantity'],
      counter: 0,
    );
  }
}
