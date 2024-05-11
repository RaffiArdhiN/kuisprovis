import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuis3_provis/cubit/auth_cubit.dart';
import 'package:kuis3_provis/page/daftar_page.dart';
// import 'package:kuis3_provis/page/daftar_page.dart';
import 'page/login_page.dart';
// import 'page/daftar_page.dart';

String loggedInToken = '';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarayaFood',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => AuthCubit(),
        child: LoginPage(),
      ),
    );
  }
}