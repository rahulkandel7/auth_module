import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_error.dart';
import '../../../../core/api/dio_exception.dart';
import '../sources/auth_data_sources.dart';

// * In this page we are getting either data or error from the api call. If we get error then that error is storing in ApiError and if we are getting sucess then the right side of either should be return

abstract class AuthDataRepository {
  Future<Either<ApiError, String>> login(
      {required String username, required String password});
  Future<Either<ApiError, String>> register(data);
  Future<Either<ApiError, String>> logout();

  Future<Either<ApiError, String>> sendPasswordResetLink(var data);
  Future<Either<ApiError, String>> codeCheck(var data);
  Future<Either<ApiError, String>> forgetChangePassword(var data);
}

final authDataRepositoryProvider = Provider<AuthDataRepository>((ref) {
  return AuthDataRepositoryImpl(ref.watch(authDataSourceProvider));
});

class AuthDataRepositoryImpl extends AuthDataRepository {
  final AuthDataSources _authDataSources;

  AuthDataRepositoryImpl(this._authDataSources);
  @override
  Future<Either<ApiError, String>> login(
      {required String username, required String password}) async {
    try {
      final result =
          await _authDataSources.login(username: username, password: password);
      return right(result);
    } on DioException catch (e) {
      return left(ApiError(message: e.message!));
    }
  }

  @override
  Future<Either<ApiError, String>> logout() async {
    try {
      final result = await _authDataSources.logout();
      return right(result);
    } on DioException catch (e) {
      return left(ApiError(message: e.message!));
    }
  }

  @override
  Future<Either<ApiError, String>> register(data) async {
    try {
      final result = await _authDataSources.register(data);
      return right(result);
    } on DioException catch (e) {
      return left(ApiError(message: e.message!));
    }
  }

  @override
  Future<Either<ApiError, String>> sendPasswordResetLink(var data) async {
    try {
      final result = await _authDataSources.sendPasswordResetLink(data);
      return right(result);
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> codeCheck(data) async {
    try {
      final result = await _authDataSources.checkCode(data);
      return right(result);
    } on DioException catch (e) {
      return Left(
        ApiError(
          message: e.message!,
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> forgetChangePassword(data) async {
    try {
      final result = await _authDataSources.forgetChnagePassword(data);
      return right(result);
    } on DioException catch (e) {
      return left(ApiError(message: e.message!));
    }
  }
}
