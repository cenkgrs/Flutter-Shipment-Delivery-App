import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Driver {
  final int id;
  final String name;

  const Driver({
    required this.id,
    required this.name,
  });
}

Future<List<Driver>> fetchDrivers() async {
  getDriversRequest().then((response) {
    if (response.statusCode == true) {
      var data = jsonDecode(response.body);

      List<Driver> result = [];

      for (var driver in data['drivers']) {
        // Get delivery address coordinates

        var latitude;
        var longitude;

        latitude = 0.0;
        longitude = 0.0;

        result.add(Driver(
          id: driver["id"],
          name: driver["name"],
        ));
      }

      return result;
    } else {
      throw Exception('Failed to load Drivers');
    }
  });

  throw Exception('Failed to load Drivers');
}

Future<http.Response> getDriversRequest() async {
  const storage = const FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/get-drivers'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  return response;
}
