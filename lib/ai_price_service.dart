import 'dart:convert';
import 'package:http/http.dart' as http;

class AiPricePrediction {
  final bool success;
  final String cropName;
  final String location;
  final double quantity;
  final double averageMarketPrice;
  final double highestMarketPrice;
  final double aiPredictedPrice;
  final double recommendedSellingPrice;
  final String recommendation;
  final int marketsAnalyzed;

  AiPricePrediction({
    required this.success,
    required this.cropName,
    required this.location,
    required this.quantity,
    required this.averageMarketPrice,
    required this.highestMarketPrice,
    required this.aiPredictedPrice,
    required this.recommendedSellingPrice,
    required this.recommendation,
    required this.marketsAnalyzed,
  });

  factory AiPricePrediction.fromJson(Map<String, dynamic> json) {
    return AiPricePrediction(
      success: json['success'] ?? false,
      cropName: json['crop_name'] ?? '',
      location: json['location'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      averageMarketPrice:
          (json['average_market_price'] ?? 0).toDouble(),
      highestMarketPrice:
          (json['highest_market_price'] ?? 0).toDouble(),
      aiPredictedPrice:
          (json['ai_predicted_price'] ?? 0).toDouble(),
      recommendedSellingPrice:
          (json['recommended_selling_price'] ?? 0).toDouble(),
      recommendation: json['recommendation'] ?? '',
      marketsAnalyzed: json['markets_analyzed'] ?? 0,
    );
  }
}

class AiPriceService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  static Future<AiPricePrediction> predictPrice({
    required String cropName,
    String location = '',
    double quantity = 0,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ai-price-prediction'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'crop_name': cropName,
        'location': location,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'AI prediction failed: ${response.statusCode}',
      );
    }

    final data = jsonDecode(response.body);

    return AiPricePrediction.fromJson(data);
  }
}