import 'package:brothers_stock/core/utils/api_service.dart';
import '../domain/user.dart';

class AuthRepository {
  Future<AppUser> login(String email, String password) async {
    final response = await ApiService.post('auth.php', {
      'action': 'login',
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      return AppUser.fromJson(response['user']);
    } else {
      throw Exception(response['message'] ?? 'Login failed');
    }
  }

  Future<AppUser> register(
    String fullname,
    String email,
    String password,
  ) async {
    final response = await ApiService.post('auth.php', {
      'action': 'register',
      'fullname': fullname,
      'email': email,
      'password': password,
    });

    if (response['status'] == 'success') {
      return AppUser.fromJson(response['user']);
    } else {
      throw Exception(response['message'] ?? 'Registration failed');
    }
  }
}
