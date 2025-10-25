import 'package:dio/dio.dart';
import 'package:hangry_app/core/network/api_error.dart';
import 'package:hangry_app/core/network/api_exceptions.dart';
import 'package:hangry_app/core/network/api_servise.dart';
import 'package:hangry_app/core/utiles/pref_helper.dart';
import 'package:hangry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiServise apiServise = ApiServise();
  bool isGuest = false;
  UserModel? _currentUser;

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
        isGuest = false;
        _currentUser = user;
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
        isGuest = false;
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "Invalid response from server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }

  //get profile
  Future<UserModel?> getUserProfile() async {
    try {
      final token = await PrefHelper.getUserToken();
      if (token == null || token == 'guest') {
        return null;
      }
      final response = await apiServise.get('/profile');

      final user = UserModel.fromJson(response['data']);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //update profile
  Future<UserModel?> updateProfile({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'email': email,
        'address': address,
        if (visa != null && visa.isNotEmpty) 'Visa': visa,
        if (imagePath != null && imagePath.isNotEmpty)
          'image': await MultipartFile.fromFile(
            imagePath,
            filename: 'profile.jpg',
          ),
      });
      final response = await apiServise.post('/update-profile', formData);
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
        _currentUser = user;
        return user;
      } else {
        throw ApiError(message: "Invalid response from server");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  //logout user
  Future<void> logoutUser() async {
    final response = await apiServise.post('/logout', {});
    if (response['data'] != null) {
      throw ApiError(message: 'failed to logout user');
    }
    await PrefHelper.clearUserToken();
    _currentUser = null;
    isGuest = true;
  }

  //countinue as guest
  Future<void> continueAsGuest() async {
    await PrefHelper.saveUserToken('guest');
    isGuest = true;
    _currentUser = null;
  }

  //auto login
  Future<UserModel?> autoLogIn() async {
    final token = await PrefHelper.getUserToken();
    if (token == null || token == 'guest') {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getUserProfile();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelper.clearUserToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => !isGuest && _currentUser != null;
}
