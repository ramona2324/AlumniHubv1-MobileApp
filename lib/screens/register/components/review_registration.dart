import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/registration_data.dart';
import '../../../services/auth_service.dart';
import '../../auth/login_screen.dart';

class ReviewRegistration extends StatefulWidget {
  final RegistrationData registrationData;

  const ReviewRegistration({
    super.key,
    required this.registrationData,
  });

  // final String fullName;
  // final String email;
  // final String phone;
  // final String educationalBackground;
  // final bool isEmployed;
  // final String? selectedWorkSetup;
  // final String? employmentType; // Add this line
  // final String? employerName;    // Add this line
  // final String? employerEmail;
  // final String? companyName;     // Add this line
  // final String workLocation;

  // const ReviewRegistration({
  //   super.key,
  //   required this.fullName,
  //   required this.email,
  //   required this.phone,
  //   required this.educationalBackground,
  //   required this.isEmployed,
  //   required this.selectedWorkSetup,
  //   required this.employmentType,   // Add this line
  //   required this.employerName,
  //   required this.employerEmail,// Add this line
  //   required this.companyName,       // Add this line
  //   required this.workLocation,
  // });

  @override
  State<ReviewRegistration> createState() => _ReviewRegistrationState();
}

class _ReviewRegistrationState extends State<ReviewRegistration> {
  final _authService = AuthService();
  bool _isSubmitting = false;

  Future<void> _submitRegistration() async {
    setState(() => _isSubmitting = true);

    try {
      await _authService.register(widget.registrationData);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
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
                          (route) => false,
                    );
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.registrationData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Review Registration"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please review you registration details:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: defaultPadding),

            _buildSection(
              "Personal Information",
              [
                _buildDetailRow("First Name:", data.firstName ?? ''),
                _buildDetailRow("Middle Name:", data.middleName ?? ''),
                _buildDetailRow("Last Name:", data.lastName ?? ''),
                _buildDetailRow("Email:", data.email ?? ''),
                _buildDetailRow("Phone:", data.phoneNumber ?? ''),
                _buildDetailRow("Gender:", data.gender ?? ''),
                _buildDetailRow(
                    "Birthday:", data.birthday?.toString().split(' ')[0] ?? ''),
                _buildDetailRow("Age:", data.age?.toString() ?? ''),
                _buildDetailRow("Address:", data.address ?? ''),
              ],
            ),

            _buildSection(
              "Academic Information",
              [
                _buildDetailRow("Campus:", data.campus ?? ''),
                _buildDetailRow("College:", data.college ?? ''),
                _buildDetailRow("Program:", data.program ?? ''),
                _buildDetailRow("Major:", data.major ?? ''),
                _buildDetailRow("Year Graduated:", data.major ?? ''),
              ],
            ),

            _buildSection(
              "Employment Information",
              [
                _buildDetailRow("Currrently Employed:",
                    data.isEmployed == true ? 'Yes' : 'No'),
                if (data.isEmployed == true) ...[
                  _buildDetailRow("Work Setup:", data.workSetup ?? ''),
                  _buildDetailRow(
                      "Employment Type:", data.employmentType ?? ''),
                  _buildDetailRow("Employer Name:", data.employerName ?? ''),
                  _buildDetailRow("Employer Email:", data.employerEmail ?? ''),
                  _buildDetailRow("Company Name:", data.companyName ?? ''),
                  _buildDetailRow("Work Location:", data.workLocation ?? ''),
                ],
              ],
            ),

            const SizedBox(height: defaultPadding),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitRegistration,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text("Confirm Registration"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value.isEmpty ? 'N/A' : value),
          ),
        ],
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Review Registration"),
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.edit),
  //           onPressed: () {
  //             Navigator.pop(context); // Go back to the previous screen to edit
  //           },
  //         ),
  //       ],
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(defaultPadding),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Text(
  //             "Please review your registration details:",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //           const SizedBox(height: defaultPadding),
  //           _buildDetailRow("Full Name:", fullName),
  //           _buildDetailRow("Email:", email),
  //           _buildDetailRow("Phone:", phone),
  //           _buildDetailRow("Educational Background:", educationalBackground),
  //           const SizedBox(height: defaultPadding),
  //           _buildDetailRow("Currently Employed:", isEmployed ? 'Yes' : 'No'),
  //           if (isEmployed) ...[
  //             _buildDetailRow("Work Setup:", selectedWorkSetup ?? 'N/A'),
  //             _buildDetailRow("Employment Type:", employmentType ?? 'N/A'), // Add this line
  //             _buildDetailRow("Employer Name:", employerName ?? 'N/A'),    // Add this line
  //             _buildDetailRow("Company Name:", companyName ?? 'N/A'),     // Add this line
  //             _buildDetailRow("Work Location:", workLocation),
  //           ],
  //           const SizedBox(height: defaultPadding),
  //           ElevatedButton(
  //             onPressed: () {
  //               // Show success modal
  //               showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) {
  //                   return AlertDialog(
  //                     title: const Text("Registration Successful"),
  //                     content: const Text(
  //                       "Your registration was successful! Please wait for an email verification.",
  //                     ),
  //                     actions: [
  //                       TextButton(
  //                         onPressed: () {
  //                           Navigator.of(context).pop(); // Close the modal
  //                           Navigator.pushAndRemoveUntil(
  //                             context,
  //                             MaterialPageRoute(
  //                               builder: (context) => const SignInScreen(),
  //                             ),
  //                                 (route) => false, // Remove all previous routes
  //                           );
  //                         },
  //                         child: const Text("OK"),
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             },
  //             child: const Text("Confirm Registration"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildDetailRow(String label, String value) {
  //   return Text("$label $value");
  // }
// }
