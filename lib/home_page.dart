import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'login_controller.dart';
import 'user_list_page.dart'; // Import the new page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _scanResult;

  // Definición de la nueva paleta de colores
  final Color _primaryColor = const Color(
    0xFF0D47A1,
  ); // Un azul oscuro y profesional
  final Color _cardHeaderColor = const Color(
    0xFF1565C0,
  ); // Un azul más brillante para cabeceras
  final Color _accentColor = const Color(0xFF4DB6AC); // Un acento de color teal
  final Color _logoutButtonColor = const Color(0xFFc0392b); // Un rojo sutil

  Future<void> _scanBarcode() async {
    var res = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SimpleBarcodeScannerPage()),
    );
    if (res != null) {
      setState(() {
        _scanResult = res.toString();
      });
      Get.snackbar('Lectura', _scanResult ?? 'No se encontro resultado');
    }
  }

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Obx(() {
      final userData = loginController.loggedInUser.value;

      if (userData == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final String nombre = userData['nombres'] ?? 'Usuario';
      final String identificacion =
          userData['identificacion'] ?? 'Identificacion';
      final String direccion =
          userData['direccion'] ?? 'Dirección no disponible';
      final String telefono = userData['telefono'] ?? 'Teléfono no disponible';
      final String email = userData['email'] ?? 'Email no disponible';
      final bool esLectura = userData['lectura'] ?? false;
      final bool esAdmin = userData['admin'] ?? false;

      final qrData =
          'Nombre: $nombre\nID: $identificacion\nDirección: $direccion\nTeléfono: $telefono\nEmail: $email';

      List<Widget> gridItems = [
        _buildOptionCard(
          icon: Icons.badge_outlined,
          text: 'Mi Tarjeta',
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return _buildIdCard(
                  context,
                  nombre,
                  identificacion,
                  direccion,
                  telefono,
                  email,
                  qrData,
                );
              },
            );
          },
        ),
        _buildOptionCard(
          icon: Icons.developer_mode,
          text: 'Desarrollador',
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => _buildDeveloperCard(),
            );
          },
        ),
      ];

      if (esLectura) {
        gridItems.add(
          _buildOptionCard(
            icon: Icons.qr_code_scanner,
            text: 'Escanear',
            onTap: _scanBarcode,
          ),
        );
      }

      if (esAdmin) {
        gridItems.add(
          _buildOptionCard(
            icon: Icons.people_alt_outlined,
            text: 'Usuarios',
            onTap: () {
              Get.to(() => UserListPage()); // Navigate to the user list page
            },
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('Bienvenido, $nombre'),
          backgroundColor: _primaryColor, // Color actualizado
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  children: gridItems,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  loginController.logout();
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _logoutButtonColor, // Color actualizado
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDeveloperCard() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              'https://uqjsytwltjcqmvghkmly.supabase.co/storage/v1/object/sign/img/Photos/juan.jpg?token=eyJraWQiOiJzdG9yYWdlLXVybC1zaWduaW5nLWtleV9kZTM2ZTllMS1mM2E4LTRiY2YtOGUzZC05OTllMjQ5MTcyNjAiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJpbWcvUGhvdG9zL2p1YW4uanBnIiwiaWF0IjoxNzYwNjQwMjgyLCJleHAiOjE3NjEyNDUwODJ9.Mjy7SEe6mdtgMqcWcrxlR_0kcXDQitALJ1j4ZVrCRig',
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Juan Diego Ramirez Silva',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'SENA CDA - Chía',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 20),
          _buildContactRow(Icons.phone_android, '3123895740'),
          const SizedBox(height: 10),
          _buildContactRow(
            Icons.email_outlined,
            'juandyramirez1998@hotmail.com',
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: _primaryColor, size: 20), // Color actualizado
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  Widget _buildIdCard(
    BuildContext context,
    String nombre,
    String identificacion,
    String direccion,
    String telefono,
    String email,
    String qrData,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Encabezado
                Container(
                  color: _cardHeaderColor, // Color actualizado
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(Icons.badge, color: Colors.white, size: 28),
                      const SizedBox(width: 10),
                      const Text(
                        'CARNET DIGITAL',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                // Contenido principal
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Columna de Foto y QR
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundColor: _primaryColor, // Color actualizado
                            child: const Icon(
                              Icons.person_outline,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          QrImageView(
                            data: qrData,
                            version: QrVersions.auto,
                            size: 100.0,
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      // Columna de Información
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailRow('Nombre', nombre),
                            const Divider(),
                            _buildDetailRow('ID', identificacion),
                            const Divider(),
                            _buildDetailRow(
                              'Dirección',
                              direccion,
                              maxLines: 2,
                            ),
                            const Divider(),
                            _buildDetailRow('Teléfono', telefono),
                            const Divider(),
                            _buildDetailRow('Email', email, maxLines: 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 50, color: _primaryColor), // Color actualizado
            const SizedBox(height: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
