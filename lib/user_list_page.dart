import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'user_list_controller.dart';

class UserListPage extends StatelessWidget {
  final UserListController _controller = Get.put(UserListController());

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: _controller.users.length,
            itemBuilder: (context, index) {
              final user = _controller.users[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${user['identificacion'] ?? ''}'),
                      Text('Nombre: ${user['nombres'] ?? ''}'),
                      Text('Dirección: ${user['direccion'] ?? ''}'),
                      Text('Teléfono: ${user['telefono'] ?? ''}'),
                      Text('Email: ${user['email'] ?? ''}'),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
