import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uqjsytwltjcqmvghkmly.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxanN5dHdsdGpjcW12Z2hrbWx5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4MzYzNDEsImV4cCI6MjA3NDQxMjM0MX0.ZtO-8VfRSrheNsfXHlY7yJuaCzFki0wPlsNhiwed4Mk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My BarCode',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: LoginPage(),
    );
  }
}
