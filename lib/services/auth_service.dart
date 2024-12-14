import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/registration_data.dart';
import 'storage_service.dart';

class AuthService {
  // static const String baseUrl = 'http://your-laravel-api-url/api';
  static const String baseUrl = 'http://10.0.2.2/api';
  // or using your Laragon virtual host:
  // static const String baseUrl = 'http://alumnihubv1.test/api';
  final StorageService _storage = StorageService();

  Future<bool> isLoggedIn() async {
    final token = await _storage.getToken();
    return token != null;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Store the token
        await _storage.saveToken(responseData['token']);

        // Store user data
        await _storage.saveUserData(json.encode(responseData['user']));

        return responseData;
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  // Future<void> register({
  //   required String firstName,
  //   required String middleName,
  //   required String lastName,
  //   required String sex,
  //   required String phone,
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse('$baseUrl/register'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'first_name': firstName,
  //         'middle_name': middleName,
  //         'last_name': lastName,
  //         'sex': sex,
  //         'phone': phone,
  //         'email': email,
  //         'password': password,
  //       }),
  //     );
  //
  //     if (response.statusCode == 201) {
  //       final responseData = json.decode(response.body);
  //       // Store the token
  //       await _storage.saveToken(responseData['token']);
  //       // Store user data
  //       await _storage.saveUserData(json.encode(responseData['user']));
  //       return responseData;
  //     } else {
  //       throw Exception('Failed to register: ${response.body}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to connect to server: $e');
  //   }
  // }

  Future<void> register(RegistrationData data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data.toJson()),
      );

      if (response.statusCode == 201) {
        final responseData = json.decode(response.body);
        // Store the token if one is returned
        if (responseData['token'] != null) {
          await _storage.saveToken(responseData['token']);
        }
        // Store user data if returned
        if (responseData['user'] != null) {
          await _storage.saveUserData(json.encode(responseData['user']));
        }
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<void> logout() async {
    try {
      final token = await _storage.getToken();
      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }
    } finally {
      // Clear stored data even if the API call fails
      await _storage.clearAll();
    }
  }

  // Get the stored token
  Future<String?> getToken() async {
    return await _storage.getToken();
  }

  // Get the stored user data
  Future<Map<String, dynamic>?> getUserData() async {
    final userData = await _storage.getUserData();
    if (userData != null) {
      return json.decode(userData);
    }
    return null;
  }
}