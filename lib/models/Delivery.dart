import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Delivery {
  final String delivery_no;
  final int driver_id;
  final String driver_name;
  final String address;
  final int st_delivery;
  final DateTime tt_delivery;
  final int st_complete;
  final DateTime tt_complete;
  final String delivered_person;
  final int distance;
  final double latitude;
  final double longitude;
  final int status;

  const Delivery({
    required this.delivery_no,
    required this.driver_id,
    required this.driver_name,
    required this.address,
    required this.st_delivery,
    required this.tt_delivery,
    required this.st_complete,
    required this.tt_complete,
    required this.delivered_person,
    required this.distance,
    required this.latitude,
    required this.longitude,
    required this.status,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    for (var delivery in json['deliveries']) {
      return Delivery(
          delivery_no: delivery["delivery_no"],
          driver_id: delivery["driver_id"],
          driver_name: delivery["driver_name"],
          address: delivery["address"],
          st_delivery: delivery["st_delivery"],
          tt_delivery: delivery["tt_delivery"],
          st_complete: delivery["st_complete"],
          tt_complete: delivery["tt_complete"],
          delivered_person: delivery["delivered_person"],
          distance: 0,
          latitude: 0.0,
          longitude: 0.0,
          status: delivery['status']);
    }

    return Delivery(
        delivery_no: json['deliveries'][0]["delivery_no"],
        driver_id: json['deliveries'][0]["driver_id"],
        driver_name: json['deliveries'][0]["driver_name"],
        address: json['deliveries'][0]["address"],
        st_delivery: json['deliveries'][0]["st_delivery"],
        tt_delivery: json['deliveries'][0]["tt_delivery"],
        st_complete: json['deliveries'][0]["st_complete"],
        tt_complete: json['deliveries'][0]["tt_complete"],
        delivered_person: json['deliveries'][0]["delivered_person"],
        distance: 0,
        latitude: 0.0,
        longitude: 0.0,
        status: json['deliveries'][0]['status']);
  }
}

Future<Delivery> fetchDelivery() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/get-deliveries'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Delivery.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

Future<List<Delivery>> fetchDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/get-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      // Get delivery address coordinates
      List<Location> locations;

      var latitude;
      var longitude;

      latitude = 0.0;
      longitude = 0.0;

      /*
      try {
        bool serviceEnabled;
        LocationPermission permission;

        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return Future.error('Location services are disabled');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }

        if (permission == LocationPermission.deniedForever) {
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        }

        locations = await locationFromAddress(delivery['address']);

        // Get current address coordinates
        Position position =
            await GeolocatorPlatform.instance.getCurrentPosition();

        // Calcule distance between 2 place
        var _distanceInMeters =
            await GeolocatorPlatform.instance.distanceBetween(
          locations[0].latitude,
          locations[0].longitude,
          position.latitude,
          position.longitude,
        );

        latitude = locations[0].latitude;
        longitude = locations[0].longitude;
      } on NoResultFoundException {
        // Handle "No results found for the address"
        latitude = 0.0;
        longitude = 0.0;
      }
      */
      result.add(Delivery(
          delivery_no: delivery["delivery_no"],
          driver_id: delivery["driver_id"],
          driver_name: delivery["driver_name"],
          address: delivery["address"],
          st_delivery: delivery["st_delivery"],
          tt_delivery:
              DateTime.now(), //delivery["tt_delivery"] ?? DateTime.now(),
          st_complete: delivery["st_complete"],
          tt_complete:
              DateTime.now(), //delivery["tt_complete"] ?? DateTime.now(),
          delivered_person: delivery["delivered_person"] ?? 'none',
          distance: 0,
          latitude: latitude,
          longitude: longitude,
          status: delivery['status']));
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

Future<List<Delivery>> fetchWaitingDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/get-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      if (delivery['status'] == 0) {
        result.add(Delivery(
            delivery_no: delivery["delivery_no"],
            driver_id: delivery["driver_id"],
            driver_name: delivery["driver_name"],
            address: delivery["address"],
            st_delivery: delivery["st_delivery"],
            tt_delivery: DateTime.now(), // delivery["tt_delivery"],
            st_complete: delivery["st_complete"],
            tt_complete: DateTime.now(), //delivery["tt_complete"],
            delivered_person: delivery["delivered_person"] ?? "none",
            distance: 0,
            latitude: 0.0,
            longitude: 0.0,
            status: delivery['status']));
      }
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

Future<List<Delivery>> fetchCompletedDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('http://127.0.0.1:8000/api/get-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      if (delivery['status'] == 1) {
        result.add(Delivery(
            delivery_no: delivery["delivery_no"],
            driver_id: delivery["driver_id"],
            driver_name: delivery["driver_name"],
            address: delivery["address"],
            st_delivery: delivery["st_delivery"],
            tt_delivery: DateTime.parse(delivery["tt_delivery"]),
            st_complete: delivery["st_complete"],
            tt_complete: DateTime.parse(delivery["tt_complete"]),
            delivered_person: delivery["delivered_person"] ?? "none",
            distance: 0,
            latitude: 0.0,
            longitude: 0.0,
            status: delivery['status']));
      }
    }

    return result;
  } else {
    throw Exception('Failed to load Delivery');
  }
}

createDelivery(deliveryNo, address, driverId) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('http://127.0.0.1:8000/api/create-delivery'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'delivery_no': deliveryNo,
      'address': address,
      'driver_id': driverId.toString()
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
