import 'package:dio/dio.dart';
import 'package:hangry_app/core/network/api_exceptions.dart';
import 'package:hangry_app/core/network/dio_client.dart';

class ApiServise {
  final DioClient _dioClient = DioClient();
  //get
  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }

  //post
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }

  //put / update
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dioClient.dio.put(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }

  //delete
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlError(e);
    }
  }
}
