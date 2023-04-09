import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:location/location.dart';
import 'package:crud_app/constants.dart';

class Delivery {
  final String delivery_no;
  final int driver_id;
  final String driver_name;
  final String firm_name;
  final String address;
  final int st_delivery;
  final DateTime? tt_delivery;
  final int st_complete;
  final DateTime? tt_complete;
  final String delivered_person;
  final int distance;
  final double? latitude;
  final double? longitude;
  final int status;

  const Delivery({
    required this.delivery_no,
    required this.driver_id,
    required this.driver_name,
    required this.firm_name,
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
          firm_name: delivery["firm_name"],
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
        firm_name: json['deliveries'][0]["firm_name"],
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
      await http.get(Uri.parse('${Constant.baseUrl}/get-deliveries'));

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

Future<List<Delivery>> fetchAllDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-all-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      var latitude;
      var longitude;

      result.add(Delivery(
          delivery_no: delivery["delivery_no"],
          driver_id: delivery["driver_id"],
          driver_name: delivery["driver_name"],
          firm_name: delivery["firm_name"],
          address: delivery["address"],
          st_delivery: delivery["st_delivery"],
          tt_delivery:
              DateTime.now(), //delivery["tt_delivery"] ?? DateTime.now(),
          st_complete: delivery["st_complete"],
          tt_complete:
              DateTime.now(), //delivery["tt_complete"] ?? DateTime.now(),
          delivered_person: delivery["delivered_person"] ?? 'none',
          distance: 0,
          latitude: double.tryParse(delivery['latitude']),
          longitude: double.tryParse(delivery['longitude']),
          status: delivery['status']));
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

// Gets deliveries according to driver
Future<List<Delivery>> fetchDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      var latitude;
      var longitude;

      result.add(Delivery(
          delivery_no: delivery["delivery_no"],
          driver_id: delivery["driver_id"],
          driver_name: delivery["driver_name"],
          firm_name: delivery["firm_name"],
          address: delivery["address"],
          st_delivery: delivery["st_delivery"],
          tt_delivery:
              DateTime.now(), //delivery["tt_delivery"] ?? DateTime.now(),
          st_complete: delivery["st_complete"],
          tt_complete:
              DateTime.now(), //delivery["tt_complete"] ?? DateTime.now(),
          delivered_person: delivery["delivered_person"] ?? 'none',
          distance: 0,
          latitude: double.tryParse(delivery['latitude']),
          longitude: double.tryParse(delivery['longitude']),
          status: delivery['status']));
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

Future<List<Delivery>> fetchActiveDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-all-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      if (delivery['status'] == 0 && delivery['st_delivery'] == 1) {
        result.add(Delivery(
            delivery_no: delivery["delivery_no"],
            driver_id: delivery["driver_id"],
            driver_name: delivery["driver_name"],
            firm_name: delivery["firm_name"],
            address: delivery["address"],
            st_delivery: delivery["st_delivery"],
            tt_delivery: delivery["tt_delivery"] == null
                ? null
                : DateTime.tryParse(delivery["tt_delivery"]),
            st_complete: delivery["st_complete"],
            tt_complete: delivery["tt_complete"] == null
                ? null
                : DateTime.tryParse(delivery["tt_complete"]),
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

Future<List<Delivery>> fetchWaitingDeliveries() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-all-deliveries'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      if (delivery['status'] == 0 && delivery['st_delivery'] == 0) {
        result.add(Delivery(
            delivery_no: delivery["delivery_no"],
            driver_id: delivery["driver_id"],
            driver_name: delivery["driver_name"],
            firm_name: delivery["firm_name"],
            address: delivery["address"],
            st_delivery: delivery["st_delivery"],
            tt_delivery: delivery["tt_delivery"] == null
                ? null
                : DateTime.tryParse(delivery["tt_delivery"]),
            st_complete: delivery["st_complete"],
            tt_complete: delivery["tt_complete"] == null
                ? null
                : DateTime.tryParse(delivery["tt_complete"]),
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
      .get(Uri.parse('${Constant.baseUrl}/get-all-deliveries'), headers: {
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
            firm_name: delivery["firm_name"],
            address: delivery["address"],
            st_delivery: delivery["st_delivery"],
            tt_delivery: delivery["tt_delivery"] == null
                ? null
                : DateTime.tryParse(delivery["tt_delivery"]),
            st_complete: delivery["st_complete"],
            tt_complete: delivery["tt_complete"] == null
                ? null
                : DateTime.tryParse(delivery["tt_complete"]),
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

createDelivery(deliveryNo, firm, address, driverId) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/create-delivery'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'delivery_no': deliveryNo,
      'firm_name': firm,
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

Future<List<Delivery>> searchDelivery(query, userType) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .post(Uri.parse('${Constant.baseUrl}/search-delivery'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  }, body: {
    'query': query.toString(),
    'user_type': userType,
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      // Get delivery address coordinates
      List<Location> locations;

      var latitude;
      var longitude;

      latitude = 0.0;
      longitude = 0.0;

      result.add(Delivery(
          delivery_no: delivery["delivery_no"],
          driver_id: delivery["driver_id"],
          driver_name: delivery["driver_name"],
          firm_name: delivery["firm_name"],
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
    throw Exception('Failed to load Delivery');
  }
}

Future<Delivery> getActiveDelivery() async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http
      .get(Uri.parse('${Constant.baseUrl}/get-active-delivery'), headers: {
    'Accept': 'application/json;',
    'Authorization': 'Bearer $token'
  });

  var latitude = 0.0;
  var longitude = 0.0;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    var delivery = data['delivery'];

    return Delivery(
        delivery_no: delivery["delivery_no"],
        driver_id: delivery["driver_id"],
        driver_name: delivery["driver_name"],
        firm_name: delivery["firm_name"],
        address: delivery["address"],
        st_delivery: delivery["st_delivery"],
        tt_delivery: delivery["tt_delivery"] == null
            ? null
            : DateTime.tryParse(delivery["tt_delivery"]),
        st_complete: delivery["st_complete"],
        tt_complete: delivery["tt_complete"] == null
            ? null
            : DateTime.tryParse(delivery["tt_complete"]),
        delivered_person: delivery["delivered_person"] ?? 'none',
        distance: 0,
        latitude: double.tryParse(delivery['latitude']),
        longitude: double.tryParse(delivery['longitude']),
        status: delivery['status']);
  } else {
    throw Exception('Failed to load Delivery');
  }
}

completeDelivery(
    String deliveryNo, String deliveredPerson, String nationalId) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/complete-delivery'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'delivery_no': deliveryNo,
      'delivered_person': deliveredPerson,
      'national_id': nationalId
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Exception(
          'Teslimat kaydı eklenemedi Lütfen irsaliye numarasını kontrol ediniz.');
    }
  } catch (e) {
    return false;
  }
}

startDelivery(Delivery delivery) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/start-delivery'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'delivery_no': delivery.delivery_no,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      var data = jsonDecode(response.body);

      return {'status': false, 'exception': data['message']};
    }
  } catch (e) {
    return {'status': false, 'exception': e.toString()};
  }
}

cancelDelivery(Delivery delivery) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  try {
    final response = await http
        .post(Uri.parse('${Constant.baseUrl}/cancel-delivery'), headers: {
      'Accept': 'application/json;',
      'Authorization': 'Bearer $token'
    }, body: {
      'delivery_no': delivery.delivery_no,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      var data = jsonDecode(response.body);

      return {'status': false, 'exception': data['message']};
    }
  } catch (e) {
    return {'status': false, 'exception': e.toString()};
  }
}

getDeliveryNo(int driverId) async {
  const storage = FlutterSecureStorage();

  // to get token from local storage
  var token = await storage.read(key: 'token');

  final response = await http.get(
      Uri.parse('${Constant.baseUrl}/get-delivery-no/$driverId'),
      headers: {
        'Accept': 'application/json;',
        'Authorization': 'Bearer $token'
      });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['status']) {
      return data['delivery_no'];
    } else {
      return '';
    }
  } else {
    return '';
  }
}
