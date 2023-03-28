import 'dart:convert';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:crud_app/constants.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'dart:math' show cos, sqrt, asin;

class Locations {
  final int driverId;
  final String driverName;
  final String address;
  final String latitude;
  final String longitude;
  final DateTime time;

  const Locations(
      {required this.driverId,
      required this.driverName,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.time});
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

launchMap(String address) {
  MapsLauncher.launchQuery(address);
}

Future<List<Locations>> getDriverLocations() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-last-locations'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    List<Locations> result = [];

    for (var location in data['locations']) {
      result.add(Locations(
              driverId: location["driver_id"],
              driverName: location["driver_name"],
              address: location["address"],
              latitude: location["latitude"],
              longitude: location["longitude"],
              time: DateTime.now()) //DateTime.tryParse(location["time"])
          );
    }

    return result;
  } else {
    throw Exception('Failed to load driver locations');
  }
}

Future<String> calculateRemainingKm(lat2, lon2) async {
  Location location = Location();
  LocationData pos = await location.getLocation();

  var lat1 = pos.latitude;
  var lon1 = pos.longitude;

  var distance = Geolocator.distanceBetween(lat1!, lon1!, lat2, lon2);

  if (distance > 1000) {
    return '${(distance / 1000).toStringAsFixed(2)} KM';
  } else {
    return '${(distance / 1000).toStringAsFixed(2)} Metre';
  }

  /*
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

  print(12742 * asin(sqrt(a)));
  return 12742 * asin(sqrt(a));
  */
}
