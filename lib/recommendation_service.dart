import 'dart:convert';
import 'package:http/http.dart' as http;

class RecommendationResult {
  final bool success;
  final String cropName;
  final String farmerLocation;
  final double quantity;

  final String recommendedMarket;
  final String marketLocation;
  final double marketPrice;

  final double averageMarketPrice;
  final double highestMarketPrice;
  final double aiPredictedPrice;
  final double recommendedSellingPrice;

  final double estimatedRevenue;
  final int marketsAnalyzed;

  final String recommendation;

  RecommendationResult({
    required this.success,
    required this.cropName,
    required this.farmerLocation,
    required this.quantity,
    required this.recommendedMarket,
    required this.marketLocation,
    required this.marketPrice,
    required this.averageMarketPrice,
    required this.highestMarketPrice,
    required this.aiPredictedPrice,
    required this.recommendedSellingPrice,
    required this.estimatedRevenue,
    required this.marketsAnalyzed,
    required this.recommendation,
  });

  factory RecommendationResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return RecommendationResult(
      success: json['success'] ?? false,
      cropName: json['crop_name'] ?? '',
      farmerLocation: json['farmer_location'] ?? '',
      quantity: (json['quantity'] ?? 0).toDouble(),
      recommendedMarket:
          json['recommended_market'] ?? '',
      marketLocation:
          json['market_location'] ?? '',
      marketPrice:
          (json['market_price'] ?? 0).toDouble(),
      averageMarketPrice:
          (json['average_market_price'] ?? 0).toDouble(),
      highestMarketPrice:
          (json['highest_market_price'] ?? 0).toDouble(),
      aiPredictedPrice:
          (json['ai_predicted_price'] ?? 0).toDouble(),
      recommendedSellingPrice:
          (json['recommended_selling_price'] ?? 0)
              .toDouble(),
      estimatedRevenue:
          (json['estimated_revenue'] ?? 0).toDouble(),
      marketsAnalyzed:
          json['markets_analyzed'] ?? 0,
      recommendation:
          json['recommendation'] ?? '',
    );
  }
}

class RecommendationService {
  static const String baseUrl =
      'http://127.0.0.1:8000';

  static Future<RecommendationResult>
      getRecommendation({
    required String cropName,
    String location = '',
    double quantity = 0,
  }) async {
    final response = await http.post(
      Uri.parse(
        '$baseUrl/recommendation-engine',
      ),
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
        'Recommendation request failed: '
        '${response.statusCode}',
      );
    }

    final data =
        jsonDecode(response.body);

    return RecommendationResult.fromJson(
      data,
    );
  }
}