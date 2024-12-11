import 'package:flutter/material.dart';
import 'package:alumnihubv1/screens/register/components/review_registration.dart';
import '../../../components/welcome_text.dart';
import '../../../constants.dart';

class RegisterStep3 extends StatefulWidget {
  final String fullName;
  final String email;
  final String phone;
  final String educationalBackground;

  const RegisterStep3({
    super.key,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.educationalBackground,
  });

  @override
  State<RegisterStep3> createState() => _RegisterStep3State();
}

class _RegisterStep3State extends State<RegisterStep3> {
  bool isEmployed = false;
  String? selectedWorkSetup;
  String? employmentType;
  final TextEditingController workLocationController = TextEditingController();
  final TextEditingController employerNameController = TextEditingController();
  final TextEditingController employerEmailController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();

  final List<String> workSetupOptions = [
    'On-site',
    'Remote/Work from Home',
    'Hybrid',
  ];

  final List<String> employmentTypes = [
    'Permanent',
    'Contract',
    'Freelance',
    'Internship',
  ];

  final _formKey = GlobalKey<FormState>();

  OutlineInputBorder _buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous step
          },
        ),
        title: const Text("Register"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WelcomeText(
                    title: "Employment Information",
                    text: "Please provide details about your current employment status.",
                  ),
                  const SizedBox(height: 16),

                  const Text("Are you currently employed?"),
                  Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: isEmployed,
                        onChanged: (value) {
                          setState(() {
                            isEmployed = value!;
                          });
                        },
                      ),
                      const Text("Yes"),
                      Radio<bool>(
                        value: false,
                        groupValue: isEmployed,
                        onChanged: (value) {
                          setState(() {
                            isEmployed = value!;
                            selectedWorkSetup = null; // Reset work setup if unemployed
                          });
                        },
                      ),
                      const Text("No"),
                    ],
                  ),
                  const SizedBox(height: 16),

                  if (isEmployed) ...[
                    // Work Setup Field
                    _buildDropdownField("Work Setup", workSetupOptions, selectedWorkSetup, (value) {
                      setState(() {
                        selectedWorkSetup = value;
                      });
                    }),
                    const SizedBox(height: 16),

                    // Nature of Employment Field
                    _buildDropdownField("Nature of Employment", employmentTypes, employmentType, (value) {
                      setState(() {
                        employmentType = value;
                      });
                    }),
                    const SizedBox(height: 16),

                    // Employer Name Field
                    _buildTextField(employerNameController, "Employer Name", "Enter your employer's name"),
                    const SizedBox(height: 16),

                    // Employer Email Field
                    _buildTextField(employerEmailController, "Employer Email", "Enter your employer's email"),
                    const SizedBox(height: 16),

                    // Company Name Field
                    _buildTextField(companyNameController, "Company Name", "Enter your company name"),
                    const SizedBox(height: 16),

                    // Work Location Field
                    _buildTextField(workLocationController, "Work Location", "Enter your work location"),
                    const SizedBox(height: 16),
                  ],

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to the review step
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewRegistration(
                              fullName: widget.fullName,
                              email: widget.email,
                              phone: widget.phone,
                              educationalBackground: widget.educationalBackground,
                              isEmployed: isEmployed,
                              selectedWorkSetup: selectedWorkSetup,
                              employmentType: employmentType,
                              employerName: employerNameController.text,
                              employerEmail: employerEmailController.text,
                              companyName: companyNameController.text,
                              workLocation: workLocationController.text,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text("Submit Registration"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint, // Use hint instead of labelText to avoid redundancy
            floatingLabelBehavior: FloatingLabelBehavior.auto, // Makes the label float
            border: _buildBorder(),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          validator: (value) {
            if (isEmployed && (value == null || value.isEmpty)) {
              return "Please enter your $label";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButtonFormField<String>(
          value: selectedValue,
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: _buildBorder(),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          ),
          validator: (value) {
            if (value == null) {
              return "Please select your $label";
            }
            return null;
          },
        ),
      ],
    );
  }
}
