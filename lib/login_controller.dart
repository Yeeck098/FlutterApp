import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'login_page.dart';
import 'home_page.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;

  var loggedInUser = Rx<Map<String, dynamic>?>(null);

  Future<void> login(String identificacion, String password) async {
    isLoading.value = true;
    message.value = '';

    if (identificacion.isEmpty || password.isEmpty) {
      message.value = 'Por favor, ingrese identificación y contraseña';
      isLoading.value = false;
      return;
    }

    final passwordMd5 = md5.convert(utf8.encode(password)).toString();
    final url = Uri.parse(
      'https://uqjsytwltjcqmvghkmly.supabase.co/rest/v1/persona?identificacion=eq.$identificacion&password=eq.$passwordMd5&select=*,lectura,admin,direccion,telefono,email',
    );

    final headers = {
      'apikey':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxanN5dHdsdGpjcW12Z2hrbWx5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4MzYzNDEsImV4cCI6MjA3NDQxMjM0MX0.ZtO-8VfRSrheNsfXHlY7yJuaCzFki0wPlsNhiwed4Mk',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVxanN5dHdsdGpjcW12Z2hrbWx5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg4MzYzNDEsImV4cCI6MjA3NDQxMjM0MX0.ZtO-8VfRSrheNsfXHlY7yJuaCzFki0wPlsNhiwed4Mk',
      'Content-Type': "application/json",
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          final persona = data.first;

          loggedInUser.value = {
            'identificacion': persona['identificacion'],
            'nombres': persona['nombres'],
            'lectura': persona['lectura'],
            'admin': persona['admin'],
            'direccion': persona['direccion'], // Dato añadido
            'telefono': persona['telefono'], // Dato añadido
            'email': persona['email'], // Dato añadido
          };

          Get.snackbar(
            '¡Bienvenido!',
            'Hola, ${persona['nombres']}. Has iniciado sesión correctamente',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(Icons.check_circle, color: Colors.white),
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 3),
          );

          Get.offAll(() => const HomePage());
        } else {
          message.value = 'Identificación o contraseña incorrecta';
        }
      } else {
        message.value = 'Error en el servidor: ${response.statusCode}';
      }
    } catch (e) {
      message.value = 'Error de conexión: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    loggedInUser.value = null;
    Get.offAll(() => LoginPage());
  }
}
