import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import 'package:intl/intl.dart';
import 'register_step2.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedGender;

  // Method to calculate age from birthdate
  void _calculateAge(String birthDateString) {
    DateTime birthDate = DateFormat('yyyy-MM-dd').parse(birthDateString);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    _ageController.text = age.toString();
  }

  // Method to show date picker
  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      _birthdayController.text = formattedDate;
      _calculateAge(formattedDate);
    }
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF800000)),
    );
  }

  void _proceedToNextStep() {
    if (_formKey.currentState?.validate() ?? false) {
      final registrationData = RegistrationData()
          ..firstName = _firstNameController.text
          ..middleName = _middleNameController.text
          ..lastName = _lastNameController.text
          ..email = _emailController.text
          ..phoneNumber = _phoneController.text
          ..gender = _selectedGender.text
          ..birthday = DateFormat('yyyy-MM-dd').parse(_birthdayController.text)
          ..age = int.tryParse(_ageController.text)
          ..address = _addressController.text;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterStep2(
            registrationData: registrationData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update your TextFormField widgets to use the controllers
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Name
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "First Name*",
                border: _buildBorder(),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Middle Name
            TextFormField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Middle Name",
                border: _buildBorder(),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Last Name
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Last Name*",
                border: _buildBorder(),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Email
            TextFormField(
              validator: (value) {
                if (value == null || !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email*",
                border: _buildBorder(),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),

            // Phone Number and Gender
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number*",
                        border: _buildBorder(),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 4), // Add some spacing between the fields
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                      validator: (value) =>
                      value == null ? 'Please select your gender' : null,
                      items: <String>['Male', 'Female', 'Non-Binary']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: "Gender*",
                        border: _buildBorder(),
                      ),
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black), // Text color
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Birthday and Age
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: TextFormField(
                      controller: _birthdayController,
                      textInputAction: TextInputAction.next,
                      readOnly: true,
                      onTap: _selectDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your birthday';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Birthday*",
                        border: _buildBorder(),
                        suffixIcon: Icon(
                          Icons.calendar_today_rounded,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: TextFormField(
                      controller: _ageController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Age",
                        border: _buildBorder(),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Complete Address
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your complete address';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Complete Address*",
                border: _buildBorder(),
              ),
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Next Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterStep2(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF800000),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
