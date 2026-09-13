import 'dart:convert';

import 'package:http/http.dart' as http;

class Shop {
  final int id;
  final String name;
  final String location;
  final String contact;
  final String category;

  const Shop({
    required this.id,
    required this.name,
    required this.location,
    required this.contact,
    required this.category,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'] as int,
      name: json['name'] as String? ?? 'Unknown Shop',
      location: json['location'] as String? ?? 'Location unavailable',
      contact: json['contact'] as String? ?? 'Contact unavailable',
      category: json['category'] as String? ?? 'Agriculture',
    );
  }
}

class ShopService {
  static const String _baseUrl = 'http://127.0.0.1:8000';

  Future<List<Shop>> getShops() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/shops'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to load shops. Server returned '
        '${response.statusCode}.',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw Exception('Invalid shop data received from server.');
    }

    return decoded
        .map(
          (item) => Shop.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  Future<List<Shop>> searchShops(String location) async {
    final cleanLocation = location.trim();

    if (cleanLocation.isEmpty) {
      return getShops();
    }

    final encodedLocation = Uri.encodeComponent(
      cleanLocation,
    );

    final response = await http.get(
      Uri.parse('$_baseUrl/shops/search/$encodedLocation'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to search shops. Server returned '
        '${response.statusCode}.',
      );
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw Exception('Invalid shop search data received.');
    }

    return decoded
        .map(
          (item) => Shop.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }
}