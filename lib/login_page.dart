import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController loginController = Get.put(LoginController());
  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Paleta de colores profesional
  final Color _primaryColor = const Color(0xFF0D47A1); // Azul oscuro y profesional
  final Color _backgroundColor = const Color(0xFFF5F5F5); // Un fondo gris claro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: _primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.lock_person_sharp,
                    size: 80,
                    color: _primaryColor,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Bienvenido',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _primaryColor,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ingresa tus credenciales para continuar',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildTextField(
                    controller: identificacionController,
                    labelText: 'Identificación',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  // Obx eliminado para corregir el error
                  _buildTextField(
                    controller: passwordController,
                    labelText: 'Contraseña',
                    icon: Icons.lock_outline,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                  Obx(() {
                    if (loginController.isLoading.value) {
                      return CircularProgressIndicator(color: _primaryColor);
                    } else {
                      return ElevatedButton(
                        onPressed: () {
                          loginController.login(
                            identificacionController.text,
                            passwordController.text,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: const Text(
                          'Ingresar',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                  }),
                  const SizedBox(height: 15),
                  Obx(() {
                    if (loginController.message.value.isNotEmpty) {
                      return Text(
                        loginController.message.value,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      );
                    }
                    return const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: _primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: _primaryColor, width: 2.0),
        ),
      ),
    );
  }
}
