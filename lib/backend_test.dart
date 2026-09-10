import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(const BackendTestApp());
}

class BackendTestApp extends StatelessWidget {
  const BackendTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CropD-UP Backend Test'),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: ApiService.checkBackend(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text(
                  'Backend connection failed:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                );
              }

              return Text(
                'Backend connected successfully!\n\n${snapshot.data}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              );
            },
          ),
        ),
      ),
    );
  }
}