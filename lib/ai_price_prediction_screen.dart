import 'package:flutter/material.dart';
import 'ai_price_service.dart';

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
    });

    try {
      final quantity =
          double.tryParse(quantityController.text.trim()) ?? 0;

      final result = await AiPriceService.predictPrice(
        cropName: cropController.text.trim(),
        location: locationController.text.trim(),
        quantity: quantity,
      );

      if (!mounted) return;

      setState(() {
        prediction = result;
        loading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
        errorMessage =
            'Unable to get AI prediction. Please check that the backend is running.';
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
              'AI analyzes available market prices and suggests a competitive selling price for your crop.',
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
                hintText: 'Example: Tomato',
                prefixIcon: const Icon(Icons.agriculture),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: 'Example: Bengaluru',
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: quantityController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Quantity (kg)',
                hintText: 'Example: 100',
                prefixIcon: const Icon(Icons.scale),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: loading ? null : predictPrice,
              icon: loading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.auto_awesome),
              label: Text(
                loading
                    ? 'Analyzing Markets...'
                    : 'Predict Best Price',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            if (errorMessage != null) ...[
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
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
                'AI Prediction Result',
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
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI Recommendation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        prediction!.recommendation,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'Markets analyzed: ${prediction!.marketsAnalyzed}',
                textAlign: TextAlign.center,
                style: const TextStyle(
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
        padding: const EdgeInsets.all(18),
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
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
}