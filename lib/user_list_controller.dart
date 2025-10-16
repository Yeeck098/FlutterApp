
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserListController extends GetxController {
  final _supabase = Supabase.instance.client;

  var users = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final response = await _supabase.from('persona').select();

      if (response != null) {
          final List<dynamic> data = response as List<dynamic>;
          users.value = data.map((item) => item as Map<String, dynamic>).toList();
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron cargar los usuarios: \${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
