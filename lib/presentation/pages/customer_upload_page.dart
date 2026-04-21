import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Customer upload & result page (placeholder for step 4).
class CustomerUploadPage extends StatelessWidget {
  const CustomerUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload & Analyze'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(child: Text('Upload + result view (step 4)')),
    );
  }
}
