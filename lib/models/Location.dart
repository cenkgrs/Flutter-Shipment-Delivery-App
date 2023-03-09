import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:crud_app/constants.dart';

class Locations {
  final int driverId;
  final String address;
  final String latitude;
  final String longitude;
  final DateTime time;

  const Locations(
      {required this.driverId,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.time,
      ge});
}

Future setLocation() async {
  Location location = Location();
  LocationData pos = await location.getLocation();

  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/add-location-record'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'address': 'Adres',
      'latitude': pos.latitude.toString(),
      'longitude': pos.longitude.toString(),
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception('Lokasyon bilgisi gönderilemedi.');
    }
  } catch (e) {
    return false;
  }
}
