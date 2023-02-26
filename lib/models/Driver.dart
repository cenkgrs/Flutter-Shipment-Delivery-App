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
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/get-drivers'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    List<Driver> result = [];

    for (var driver in data['drivers']) {
      result.add(Driver(
        id: driver["id"],
        name: driver["name"],
      ));
    }

    return result;
  } else {
    throw Exception('Failed to load Drivers');
  }
}
