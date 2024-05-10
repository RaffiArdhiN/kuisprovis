// tinggal ui nya

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarayaFood Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AuthBloc(),
        child: LoginPage(),
      ),
    );
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
  }

  void _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _login(event.username, event.password);
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

  Future<http.Response> _login(String username, String password) {
    return http.post(
      Uri.parse('http://146.190.109.66:8000/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
  }

void _onRegisterRequested(AuthRegisterRequested event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  try {
    final response = await _register(event.username, event.password);
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

Future<http.Response> _register(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://146.190.109.66:8000/users/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );
  return response;
}
}

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is AuthLoggedIn) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authBloc.add(AuthLoginRequested(
                        _usernameController.text,
                        _passwordController.text,
                      ));
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      authBloc.add(AuthRegisterRequested(
                        _usernameController.text,
                        _passwordController.text,
                      ));
                    },
                    child: Text('Register'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome!'),
      ),
    );
  }
}

abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String username;
  final String password;

  AuthLoginRequested(this.username, this.password);
}

class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String password;

  AuthRegisterRequested(this.username, this.password);
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final String token;

  AuthLoggedIn(this.token);
}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String errorMessage;

  AuthError(this.errorMessage);
}