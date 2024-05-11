import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auth_event.dart';
import 'auth_state.dart';
import 'auth_repository.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository = AuthRepository();

  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.login(username, password);
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final token = body['access_token'];
        emit(AuthLoggedIn(token));
      } else {
        final errorMessage = json.decode(response.body)['detail'];
        emit(AuthError(errorMessage));
      }
    } catch (e) {
      emit(AuthError('Login failed: $e'));
    }
  }

  Future<void> daftar(String username, String password) async {
    emit(AuthLoading());
    try {
      final response = await _authRepository.daftar(username, password);
      if (response.statusCode == 200) {
        emit(AuthSuccess('Registration successful. Please login.'));
      } else {
        final errorMessage = json.decode(response.body)['detail'];
        emit(AuthError('Registration failed: $errorMessage'));
      }
    } catch (e) {
      emit(AuthError('Registration failed: $e'));
    }
  }
}
