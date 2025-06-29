class VerificationResult {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;

  VerificationResult({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  // Factory constructor to create a VerificationResult from the API's JSON structure
  factory VerificationResult.fromJson(Map<String, dynamic> json) {
    // Navigate safely through the expected JSON structure
    final personMap = json['payloadForDevelopment']?['data']?['person'] as Map<String, dynamic>?;
    
    // If the core 'person' object doesn't exist, we can't proceed.
    if (personMap == null) {
      print("Warning: 'person' data not found in the expected structure.");
      return VerificationResult(); // Return an empty object
    }

    // The 'contact' object is nested within 'person'
    final contactMap = personMap['contact'] as Map<String, dynamic>?;
    
    // --- START OF THE MAIN FIX ---
    // 1. Get the list of phone numbers. It's a List<dynamic>.
    final phoneNumbersList = contactMap?['phoneNumbers'] as List<dynamic>?;
    
    // 2. Safely extract the phone number string.
    String? finalPhoneNumber;
    if (phoneNumbersList != null && phoneNumbersList.isNotEmpty) {
      // Get the first map in the list
      final firstPhoneMap = phoneNumbersList.first as Map<String, dynamic>?;
      // Get the 'phoneNumber' value from that map
      finalPhoneNumber = firstPhoneMap?['phoneNumber'] as String?;
    }
    // --- END OF THE MAIN FIX ---

    return VerificationResult(
      // 'forenames' is the source for the first name
      firstName: personMap['forenames'] as String?,
      // 'surname' is the source for the last name
      lastName: personMap['surname'] as String?,
      
      // Email is correctly sourced from the contactMap.
      email: contactMap?['email'] as String?,

      // Use the phone number we safely extracted above.
      phoneNumber: finalPhoneNumber,
    );
  }

  // Helper to check if the result contains valid data
  bool get isValid =>
      firstName != null &&
      lastName != null &&
      email != null &&
      phoneNumber != null;

  @override
  String toString() {
    return '''
First Name:   $firstName
Last Name:    $lastName
Email:        $email
Phone Number: $phoneNumber
''';
  }
}