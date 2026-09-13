import 'package:flutter/material.dart';
import 'ai_price_service.dart';
import 'recommendation_service.dart';

class AiPricePredictionScreen extends StatefulWidget {
  const AiPricePredictionScreen({super.key});

  @override
  State<AiPricePredictionScreen> createState() =>
      _AiPricePredictionScreenState();
}

class _AiPricePredictionScreenState
    extends State<AiPricePredictionScreen> {
  final TextEditingController cropController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController quantityController =
      TextEditingController();

  AiPricePrediction? prediction;
  RecommendationResult? recommendation;

  bool loading = false;
  String? errorMessage;

  Future<void> predictPrice() async {
    if (cropController.text.trim().isEmpty) {
      setState(() {
        errorMessage = 'Please enter a crop name.';
      });
      return;
    }

    setState(() {
      loading = true;
      errorMessage = null;
      prediction = null;
      recommendation = null;
    });

    try {
      final cropName = cropController.text.trim();
      final location = locationController.text.trim();

      final quantity =
          double.tryParse(quantityController.text.trim()) ?? 0;

      // ------------------------------------------
      // 1. Get AI price prediction
      // ------------------------------------------
      final priceResult =
          await AiPriceService.predictPrice(
        cropName: cropName,
        location: location,
        quantity: quantity,
      );

      // ------------------------------------------
      // 2. Get best market recommendation
      // ------------------------------------------
      final recommendationResult =
          await RecommendationService.getRecommendation(
        cropName: cropName,
        location: location,
        quantity: quantity,
      );

      if (!mounted) return;

      setState(() {
        prediction = priceResult;
        recommendation = recommendationResult;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        errorMessage =
            'Unable to get AI recommendation. '
            'Please check that the backend is running.';
      });
    }
  }

  @override
  void dispose() {
    cropController.dispose();
    locationController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Price Prediction'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.auto_awesome,
              size: 60,
            ),

            const SizedBox(height: 12),

            const Text(
              'Find a Better Selling Price',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'AI analyzes market prices and recommends '
              'the best selling opportunity for your crop.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 28),

            TextField(
              controller: cropController,
              decoration: InputDecoration(
                labelText: 'Crop Name',
                hintText: 'Example: Potato',
                prefixIcon:
                    const Icon(Icons.agriculture),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Example: Bengaluru',
                prefixIcon:
                    const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: quantityController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Quantity (kg)',
                hintText: 'Example: 500',
                prefixIcon:
                    const Icon(Icons.scale),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed:
                  loading ? null : predictPrice,
              icon: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(
                      Icons.auto_awesome,
                    ),
              label: Text(
                loading
                    ? 'Analyzing Markets...'
                    : 'Find Best Selling Opportunity',
              ),
              style:
                  ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                textStyle:
                    const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding:
                      const EdgeInsets.all(16),
                  child: Text(
                    errorMessage!,
                    style:
                        const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],

            if (prediction != null &&
                prediction!.success) ...[
              const SizedBox(height: 28),

              const Text(
                'AI Price Analysis',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              _priceCard(
                'Average Market Price',
                '₹${prediction!.averageMarketPrice.toStringAsFixed(2)} / kg',
                Icons.analytics,
              ),

              const SizedBox(height: 12),

              _priceCard(
                'Highest Market Price',
                '₹${prediction!.highestMarketPrice.toStringAsFixed(2)} / kg',
                Icons.trending_up,
              ),

              const SizedBox(height: 12),

              _priceCard(
                'AI Predicted Price',
                '₹${prediction!.aiPredictedPrice.toStringAsFixed(2)} / kg',
                Icons.auto_awesome,
              ),

              const SizedBox(height: 12),

              _priceCard(
                'Recommended Selling Price',
                '₹${prediction!.recommendedSellingPrice.toStringAsFixed(2)} / kg',
                Icons.sell,
              ),

              const SizedBox(height: 20),

              Card(
                elevation: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'AI Recommendation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        prediction!.recommendation,
                        style:
                            const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Markets analyzed: '
                '${prediction!.marketsAnalyzed}',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],

            // ------------------------------------------
            // BEST MARKET RECOMMENDATION
            // ------------------------------------------
            if (recommendation != null &&
                recommendation!.success) ...[
              const SizedBox(height: 30),

              const Text(
                'Best Market Recommendation',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Card(
                elevation: 4,
                child: Padding(
                  padding:
                      const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.store,
                            size: 32,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Recommended Market',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Text(
                        recommendation!
                            .recommendedMarket,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            recommendation!
                                .marketLocation,
                            style:
                                const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      const Divider(),

                      const SizedBox(height: 12),

                      _recommendationRow(
                        'Market Price',
                        '₹${recommendation!.marketPrice.toStringAsFixed(2)} / kg',
                      ),

                      const SizedBox(height: 10),

                      _recommendationRow(
                        'Your Quantity',
                        '${recommendation!.quantity.toStringAsFixed(0)} kg',
                      ),

                      const SizedBox(height: 10),

                      _recommendationRow(
                        'Expected Revenue',
                        '₹${recommendation!.estimatedRevenue.toStringAsFixed(2)}',
                      ),

                      const SizedBox(height: 18),

                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.all(14),
                        decoration:
                            BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                        ),
                        child: Text(
                          recommendation!
                              .recommendation,
                          style:
                              const TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Recommendation based on '
                '${recommendation!.marketsAnalyzed} '
                'available markets.',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _priceCard(
    String title,
    String price,
    IconData icon,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(
              icon,
              size: 34,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style:
                        const TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendationRow(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
