import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:crud_app/constants.dart';

class Location {
  final int driverId;
  final String address;
  final String latitude;
  final String longitude;
  final DateTime time;

  const Location({
    required this.driverId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.time,
  });

}