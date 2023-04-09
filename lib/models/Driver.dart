import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crud_app/constants.dart';

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

  final response = await http.get(Uri.parse('${Constant.baseUrl}/get-drivers'),
      headers: {
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

checkDriverStatus(driverId) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http.get(
      Uri.parse(
          '${Constant.baseUrl}/check-driver-status/' + driverId.toString()),
      headers: {
        'Accept': 'application/json;',
        'Authorization': 'Bearer $token'
      });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    return data['status'];
  } else {
    return false;
  }
}

createDriver(name, email, password) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/create-driver'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'driver_name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

getDriver(id) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-driver/$id'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    var driver = data['driver'];

    return Driver(
      id: driver["id"],
      name: driver["name"],
    );
  } else {
    throw Exception('Failed to load Driver');
  }
}
