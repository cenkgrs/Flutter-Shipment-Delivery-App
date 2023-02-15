import 'dart:convert';
import 'package:http/http.dart' as http;

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
        status: json['deliveries'][0]['status']);
    );
  }
}

Future<Delivery> fetchDelivery() async {
  final response =
      await http.get(Uri.parse('http://bysurababy.com/api/get-deliveries'));

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
  final response =
      await http.get(Uri.parse('http://bysurababy.com/api/get-deliveries'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var delivery in data['deliveries']) {
      result.add(Delivery(
        delivery_no: delivery["delivery_no"],
        driver_id: delivery["driver_id"],
        driver_name: delivery["driver_name"],
        address: delivery["address"],
        st_delivery: delivery["st_delivery"],
        tt_delivery: delivery["tt_delivery"],
        st_complete: delivery["st_complete"],
        tt_complete: delivery["tt_complete"],
        delivered_person: delivery["delivered_person"],
        status: delivery['status'])
      );
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}

Future<List<Delivery>> fetchCompletedDeliveries() async {
  final response =
      await http.get(Uri.parse('http://bysurababy.com/api/get-deliveries'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
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
          tt_delivery: delivery["tt_delivery"],
          st_complete: delivery["st_complete"],
          tt_complete: delivery["tt_complete"],
          delivered_person: delivery["delivered_person"],
          status: delivery['status'])
        );
      }
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}