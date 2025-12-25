import 'package:flutter/material.dart';
import 'package:flutter_php_provider/presentation/authentication/login.dart';
import 'package:flutter_php_provider/presentation/provider/user_model_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserModelProvider())],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Login()),
    );
  }
}
