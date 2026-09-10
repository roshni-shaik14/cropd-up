import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const CropApiTestApp());
}

class CropApiTestApp extends StatelessWidget {
  const CropApiTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CropD-UP Crop API Test'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: ApiService.getCrops(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Failed to load crops:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              );
            }

            final crops = snapshot.data ?? [];

            return ListView.builder(
              itemCount: crops.length,
              itemBuilder: (context, index) {
                final crop = crops[index];

                return ListTile(
                  title: Text(crop['crop_name']),
                  subtitle: Text(
                    'Quantity: ${crop['quantity']} | '
                    'Price: ₹${crop['expected_price']} | '
                    'Location: ${crop['location']}',
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}