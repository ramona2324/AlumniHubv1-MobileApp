// In screens/jobs/jobs_screen.dart
import 'package:flutter/material.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jobs')),
      body: const Center(child: Text('Explore job opportunities!')),
    );
  }
}
