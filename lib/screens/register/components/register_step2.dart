import 'package:alumnihubv1/screens/Register/components/register_step3.dart';
import 'package:flutter/material.dart';
import '../../../components/welcome_text.dart';
import '../../../constants.dart';

class RegisterStep2 extends StatefulWidget {
  const RegisterStep2({super.key});

  @override
  State<RegisterStep2> createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  final _formKey = GlobalKey<FormState>();
  final List<String> campuses = ["Tagum Campus", "Mabini Campus"];
  final List<String> colleges = [
    "College of Teacher Education and Technology",
    "College of Agriculture and Related Sciences",
    "School of Medicine"
  ];
  final List<String> programs = [
    "BS in Agricultural and Biosystems Engineering",
    "BS in Information Technology",
    "BS in Forestry",
    "Bachelor of Elementary Education",
    "Bachelor of Secondary Education",
    "Bachelor of Technical-Vocational Teacher Education",
    "Bachelor of Early Childhood Education",
    "Bachelor of Special Needs Education"
  ];

  String? selectedCampus;
  String? selectedCollege;
  String? selectedProgram;
  String fullName = "";
  String email = "";
  String phone = "";
  String educationalBackground = "";

  OutlineInputBorder _buildBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // WelcomeText widget for Academic Information
              const WelcomeText(
                title: "Academic Information",
                text: "To apply as an alumni, please complete the necessary \nacademic information fields below.",
              ),

              // Registration form fields
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Step 1: Campus selection
                    DropdownButtonFormField<String>(
                      value: selectedCampus,
                      items: campuses.map((campus) {
                        return DropdownMenuItem(
                          value: campus,
                          child: Text(
                            campus,
                            style: const TextStyle(color: Colors.black), // Ensures visible text color
                          ),
                        );
                      }).toList(),
                      onChanged: (value) => setState(() {
                        selectedCampus = value;
                        selectedCollege = null;
                        selectedProgram = null;
                      }),
                      decoration: InputDecoration(
                        labelText: "Campus",
                        border: _buildBorder(),
                      ),
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      validator: (value) => value == null ? "Select a campus" : null,
                    ),
                    const SizedBox(height: 8),

                    // Step 2: College selection, shown after Campus is selected
                    if (selectedCampus != null)
                      Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedCollege,
                            items: colleges.map((college) {
                              return DropdownMenuItem(
                                value: college,
                                child: Text(
                                  college,
                                  style: const TextStyle(color: Colors.black), // Ensures visible text color
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() {
                              selectedCollege = value;
                              selectedProgram = null;
                            }),
                            decoration: InputDecoration(
                              labelText: "College",
                              border: _buildBorder(),
                            ),
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                            validator: (value) => value == null ? "Select a college" : null,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Step 3: Program and Major selection, shown after College is selected
                    if (selectedCollege != null)
                      Column(
                        children: [
                          DropdownButtonFormField<String>(
                            value: selectedProgram,
                            items: programs.map((program) {
                              return DropdownMenuItem(
                                value: program,
                                child: Text(
                                  program,
                                  style: const TextStyle(color: Colors.black), // Ensures visible text color
                                ),
                              );
                            }).toList(),
                            onChanged: (value) => setState(() => selectedProgram = value),
                            decoration: InputDecoration(
                              labelText: "Program",
                              border: _buildBorder(),
                            ),
                            style: const TextStyle(fontSize: 14, color: Colors.black),
                            validator: (value) => value == null ? "Select a program" : null,
                          ),
                          const SizedBox(height: 8),

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Major",
                              border: _buildBorder(),
                            ),
                            style: const TextStyle(fontSize: 14),
                            textInputAction: TextInputAction.next,
                            validator: (value) => value!.isEmpty ? "Enter your major" : null,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),

                    // Step 4: Year Graduated and Next button, shown after Program is selected
                    if (selectedProgram != null)
                      Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Year Graduated",
                              border: _buildBorder(),
                            ),
                            style: const TextStyle(fontSize: 14),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            validator: (value) => value!.isEmpty ? "Enter your graduation year" : null,
                          ),
                          const SizedBox(height: 24),

                          // Next Button
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState?.validate() == true) {
                                // Navigate to RegisterStep3 with required parameters
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterStep3(
                                      fullName: fullName,
                                      email: email,
                                      phone: phone,
                                      educationalBackground: educationalBackground,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Text("Next"),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}