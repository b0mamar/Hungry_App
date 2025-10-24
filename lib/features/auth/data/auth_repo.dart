import 'package:dio/dio.dart';
import 'package:hangry_app/core/network/api_error.dart';
import 'package:hangry_app/core/network/api_exceptions.dart';
import 'package:hangry_app/core/network/api_servise.dart';
import 'package:hangry_app/core/utiles/pref_helper.dart';
import 'package:hangry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiServise apiServise = ApiServise();

  // Login User
  Future<UserModel> loginUser(String email, String password) async {
    try {
      final response = await apiServise.post('/login', {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final status = response['code'];
        final data = response['data'];
        if (status != 200 && status != 201 && data == null) {
          throw ApiError(message: msg ?? "Uknown error occurred");
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveUserToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "Invalid response from server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }

  // Register User
  Future<UserModel?> registerUser(
    String name,
    String email,
    String password,
  ) async {
    try {
      final response = await apiServise.post('/register', {
        'name': name,
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final status = response['code'];
        final coder = int.tryParse(status);
        final data = response['data'];
        if (coder != 200 && coder != 201 && data == null) {
          throw ApiError(message: msg ?? "Uknown error occurred");
        }
        final user = UserModel.fromJson(response['data']);
        if (user.token != null) {
          await PrefHelper.saveUserToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "Invalid response from server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }
}
