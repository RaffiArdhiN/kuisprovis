import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuis3_provis/cubit/auth_cubit.dart';
import 'package:kuis3_provis/itemlistcoba.dart';
import 'package:kuis3_provis/cubit/auth_state.dart';
import 'package:kuis3_provis/dashboard.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _loggedInToken; // Inisialisasi awal variabel loggedInToken

  // Definisikan metode setLoggedInToken
  void setLoggedInToken(String token) {
    _loggedInToken = token;
  }

  // Definisikan metode getLoggedInToken
  String? getLoggedInToken() {
    return _loggedInToken;
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
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
            setLoggedInToken(state.token); // Memanggil setLoggedInToken
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => ItemListPage(token: getLoggedInToken() ?? '')));
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => BarayaFoodApp()));
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
                  // Image.asset('assets/gofood_logo.png'), // Tambahkan logo GoFood
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person), // Icon untuk username
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock), // Icon untuk password
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      authCubit.login(_usernameController.text, _passwordController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.green, // Warna tombol sesuai dengan GoFood
                      backgroundColor: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
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