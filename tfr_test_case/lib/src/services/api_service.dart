import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../models/order_model.dart';
import 'token_service.dart';

class ApiService {
  static const String _baseUrl = 'http://134.122.118.186/api/v1';

  static Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      print('Login isteği gönderiliyor: ${request.toJson()}');

      final response = await http.post(
        Uri.parse('$_baseUrl/token/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      print('API Yanıtı: ${response.statusCode}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Parsed Data: $data');

        // API'den gelen token'ı access olarak alıyoruz
        final token = data['access'] as String;
        if (token.isNotEmpty) {
          print('Token alındı: $token');
          TokenService.setToken(token);
          return LoginResponseModel(token: token);
        }
        return LoginResponseModel.withError('Token not found in response');
      } else {
        return LoginResponseModel.withError('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Login Error: $e');
      return LoginResponseModel.withError('Network error: $e');
    }
  }

  static Future<List<OrderModel>> getOrders() async {
    if (!TokenService.hasToken) {
      throw Exception('No token available. Please login first.');
    }

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/order-drivers/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${TokenService.token}',
        },
      );

      print('Orders API Response: ${response.statusCode}');
      print('Orders Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['results'] ?? [];
        print('Parsed Orders Data: $data');
        return data.map((json) => OrderModel.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        TokenService.clearToken();
        throw Exception('Unauthorized access. Please login again.');
      } else {
        throw Exception('Failed to load orders: ${response.statusCode}');
      }
    } catch (e) {
      print('Orders Error: $e');
      throw Exception('Network error: $e');
    }
  }
} 