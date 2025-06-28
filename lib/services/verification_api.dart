// lib/services/ghana_card_service.dart

import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_government_app/models/verification_results.dart';
//import 'package:sim_registration/models/verification_result.dart';

class GhanaCardService {
  // --- API Details ---
  final String _tokenUrl = "https://peoplespay.com.gh/peoplepay/hub/token/get";
  final String _verificationUrl =
      "https://peoplespay.com.gh/peoplepay/verification/ghcard/verify";
  final String _apiKeyForToken = "93064247-4668-4c73-ac43-4dcc28773a86";
  // !!! IMPORTANT: REPLACE WITH YOUR *REAL* API SECRET !!!
  // Consider using environment variables or a secure config management solution
  //final String _apiSecretForToken =
      //"YOUR_ACTUAL_API_SECRET_HERE"; // <-- CRITICAL: REPLACE THIS
  final String _merchantId = "63b59e41530aeeaec59a045f"; // Your merchant ID
  //final String _verificationUserId = "64d0e0ee3c4019b3cd0a2ef9"; // Your user ID for verification
  //final String _userType = "customer";
  // --- End API Details ---

  // --- Function to Generate Token ---
  Future<String?> generateToken() async {
    final requestPayload = {
      'merchantId': _merchantId,
      'apikey': _apiKeyForToken,
      // Check API docs if 'grant_type' is needed or if secret should be in payload/headers
      // 'apiSecret': _apiSecretForToken, // <-- Example: Might be needed here or as Basic Auth
    };
    final requestBodyJson = jsonEncode(requestPayload);

    print("--- Sending Token Request (Service) ---");
    print("URL: $_tokenUrl");
    print("Headers: {'Content-Type': 'application/json'}");
    print("Body (JSON): $requestBodyJson");
    print("--------------------------");

    try {
      final response = await http.post(
        Uri.parse(_tokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBodyJson,
      );

      print("Token Response Status: ${response.statusCode}");
      print("Token Response Body: ${response.body}");
      print("--------------------------");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String? token = data['data'] ?? data['access_token'] ?? data['token'];

        if (token != null && token.isNotEmpty) {
          return token;
        } else {
          print("Error: Token received, but the token field was missing or empty.");
          return null; // Indicate failure
        }
      } else {
         String errorMsg;
         try {
           final errorData = jsonDecode(response.body);
           errorMsg = "Token API Error ${response.statusCode}: ${errorData['message'] ?? errorData['error_description'] ?? errorData['error'] ?? errorData['detail'] ?? response.body}";
         } catch (_) {
           errorMsg = "Token API Error ${response.statusCode}: ${response.body}";
         }
        print("Error: $errorMsg");
        return null; // Indicate failure
      }
    } catch (e) {
      print("HTTP Error during Token Request: $e");
      return null; // Indicate failure due to network or other error
    }
  }

  // --- Function to Send Verification Data ---
  // Returns VerificationResult on success, null on failure
  Future<VerificationResult?> verifyGhanaCard({
    required String pin,
    required File imageFile,
    required String token,
  }) async {
    try {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      final payload = jsonEncode({
        'pin': pin,
        'image': base64Image,
        'id': "64d0e0ee3c4019b3cd0a2ef9",
        'userType': "customer",
      });

      print("--- Sending Verification Request (Service) ---");
      print("URL: $_verificationUrl");
      print("Headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer <TOKEN>'}");
      print("Body Keys: ${jsonDecode(payload).keys}"); // Log keys
      print("--------------------------");


      final response = await http.post(
        Uri.parse(_verificationUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: payload,
      );

      print("Verification Response Status: ${response.statusCode}");
      print("Verification Response Body: ${response.body}");
      print("--------------------------");


      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Use the factory constructor from the model
        final result = VerificationResult.fromJson(data);

        // Optional: Check if the parsed result actually contains data
        if (result.firstName != null && result.firstName!.isNotEmpty) {
             return result;
        } else {
            print("Error: Verification response OK (200), but expected user data structure was missing or empty in the response.");
            // Log the raw response body here for debugging if needed
            // print("Raw response causing parsing issue: ${response.body}");
            return null; // Indicate failure due to unexpected structure
        }
      } else {
        // Handle verification API error
        String errorMsg;
        String? apiMsg; // To store the specific message from the API response
         try {
           final errorData = jsonDecode(response.body);
            apiMsg = errorData['message'] ?? errorData['payloadForDevelopment']?['msg'] ?? errorData['error_description'] ?? errorData['error'] ?? errorData['detail'];
            errorMsg = "Verification API Error ${response.statusCode}: ${apiMsg ?? response.body}";
         } catch (_) {
           errorMsg = "Verification API Error ${response.statusCode}: ${response.body}";
         }
        print("Error: $errorMsg");
        // You could potentially return the apiMsg here if the UI needs it
        return null; // Indicate failure
      }
    } catch (e) {
      print("Error during Verification Request processing: $e");
      return null; // Indicate failure
    }
  }
}