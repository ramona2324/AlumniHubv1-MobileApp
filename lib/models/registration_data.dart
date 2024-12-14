class RegistrationData {
  // Step 1
  // Personal Information
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? gender;
  String? birthday;
  int? age;
  String? address;

  // Step 2 data fields will go here
  // Academic Information
  String? campus;
  String? college;
  String? program;
  String? major;
  int? yearGraduated;

  // Step 3 data fields will go here
  // Employment Information
  bool? isEmployed;
  String? workSetup;
  String? employmentType;
  String? employerName;
  String? employerEmail;
  String? companyName;
  String? workLocation;

  // Update toJson method to include new fields
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'gender': gender,
      'birthday': birthday?.toIso8601String(),
      'age': age,
      'address': address,

      'campus': campus,
      'college': college,
      'program': program,
      'major': major,
      'year_graduated': yearGraduated,

      'is_employed': isEmployed,
      'work_setup': workSetup,
      'employment_type': employmentType,
      'employer_name': employerName,
      'employer_email': employerEmail,
      'company_name': companyName,
      'work_location': workLocation
    };
  }
}

extension on String? {
  toIso8601String() {}
}