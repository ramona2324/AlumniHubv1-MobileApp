import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../auth/login_screen.dart';

class ReviewRegistration extends StatelessWidget {
  final String fullName;
  final String email;
  final String phone;
  final String educationalBackground;
  final bool isEmployed;
  final String? selectedWorkSetup;
  final String? employmentType; // Add this line
  final String? employerName;    // Add this line
  final String? employerEmail;
  final String? companyName;     // Add this line
  final String workLocation;

  const ReviewRegistration({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.educationalBackground,
    required this.isEmployed,
    required this.selectedWorkSetup,
    required this.employmentType,   // Add this line
    required this.employerName,
    required this.employerEmail,// Add this line
    required this.companyName,       // Add this line
    required this.workLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Registration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen to edit
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please review your registration details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding),
            _buildDetailRow("Full Name:", fullName),
            _buildDetailRow("Email:", email),
            _buildDetailRow("Phone:", phone),
            _buildDetailRow("Educational Background:", educationalBackground),
            const SizedBox(height: defaultPadding),
            _buildDetailRow("Currently Employed:", isEmployed ? 'Yes' : 'No'),
            if (isEmployed) ...[
              _buildDetailRow("Work Setup:", selectedWorkSetup ?? 'N/A'),
              _buildDetailRow("Employment Type:", employmentType ?? 'N/A'), // Add this line
              _buildDetailRow("Employer Name:", employerName ?? 'N/A'),    // Add this line
              _buildDetailRow("Company Name:", companyName ?? 'N/A'),     // Add this line
              _buildDetailRow("Work Location:", workLocation),
            ],
            const SizedBox(height: defaultPadding),
            ElevatedButton(
              onPressed: () {
                // Show success modal
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Registration Successful"),
                      content: const Text(
                        "Your registration was successful! Please wait for an email verification.",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the modal
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignInScreen(),
                              ),
                                  (route) => false, // Remove all previous routes
                            );
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Confirm Registration"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Text("$label $value");
  }
}
