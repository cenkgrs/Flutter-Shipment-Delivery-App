import 'dart:convert';
import 'package:http/http.dart' as http;

class Delivery {
  final String title;

  const Delivery({
    required this.title,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    for (var product in json['response']['products']) {
      return Delivery(title: product["name"]);
    }

    return Delivery(
      title: json['response']['products']['name'],
    );
  }
}

Future<Delivery> fetchDelivery() async {
  final response =
      await http.get(Uri.parse('http://bysurababy.com/api/get-products'));

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
      await http.get(Uri.parse('http://bysurababy.com/api/get-products'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);

    List<Delivery> result = [];

    for (var product in data['response']['products']) {
      result.add(Delivery(title: product['name']));
    }

    return result;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Delivery');
  }
}
