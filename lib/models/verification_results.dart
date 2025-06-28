// lib/models/verification_result.dart

class VerificationResult {
  final String? firstName;
  final String? lastName;

  VerificationResult({
    this.firstName,
    this.lastName,
  });

  // Factory constructor to create a VerificationResult from the API's JSON structure
  factory VerificationResult.fromJson(Map<String, dynamic> json) {
    // Navigate safely through the expected JSON structure
    final personMap = json['payloadForDevelopment']?['data']?['person'] as Map<String, dynamic>?;

    if (personMap == null) {
      // Return an empty result or throw an error if the structure is invalid
      // Depending on how strictly you want to enforce the format.
      // Returning an empty object might be safer if the API structure can vary slightly.
      print("Warning: 'person' data not found in the expected structure.");
      return VerificationResult(
        firstName: null,
        lastName: null,
      );
    }

    return VerificationResult(
      firstName: personMap['forenames'] as String?, // Use 'as String?' for type safety
      lastName: personMap['surname'] as String?,
    );
  }

   // Helper to check if the result contains valid data (optional but useful)
   bool get isValid =>
       firstName != null && firstName!.isNotEmpty &&
       lastName != null && lastName!.isNotEmpty;
       
}