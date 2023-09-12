import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_ecommerce_bloc_app/data/auth_api/entities/user_entity.dart';

class ApiClient {
  Future<dynamic> post() async {
    final response = await http.post(
      Uri.parse(
        'https://staging.get-licensed.co.uk/guardpass/api/auth/create',
      ),
      body: {
        'email_address': 'test@test.com',
        'password': 'test',
        'confirm_password': 'test'
      },
    );

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    return UserEntity(
      id: '1',
      name: 'Talha',
      email: decoded['email_address'] as String,
    );
  }
}
