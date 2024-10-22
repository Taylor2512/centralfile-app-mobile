import 'package:get/get.dart';
import '../../data/local_storage.dart';

class ContactController extends GetxController {
  var contacts = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var originalContacts = <Map<String, dynamic>>[];  // Para restaurar después de la búsqueda

  @override
  void onInit() {
    super.onInit();
    loadContacts();
  }

  // Cargar contactos desde almacenamiento local
  void loadContacts() async {
    isLoading(true);
    hasError(false);  // Reiniciar el estado de error al cargar
    try {
      contacts.value = await LocalStorage.getContacts();  // Cargar contactos desde persistencia
      originalContacts = List.from(contacts);  // Hacer copia para restaurar después de búsqueda
    } catch (e) {
      hasError(true);
      errorMessage('Error loading contacts: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  void addContact(Map<String, dynamic> contact) async {
    isLoading(true);
    hasError(false);
    try {
      await LocalStorage.addContact(contact);
      contacts.add(contact);
      originalContacts.add(contact);
    } catch (e) {
      hasError(true);
      errorMessage('Error adding contact: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Actualizar un contacto existente
  void updateContact(int index, Map<String, dynamic> contact) async {
    isLoading(true);
    hasError(false);
    try {
      await LocalStorage.updateContact(index, contact);
      contacts[index] = contact;
      originalContacts[index] = contact;  // Actualizar lista original
    } catch (e) {
      hasError(true);
      errorMessage('Error updating contact: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Eliminar contacto
  void deleteContact(int index) async {
    isLoading(true);
    hasError(false);
    try {
      await LocalStorage.deleteContact(index);
      contacts.removeAt(index);
      originalContacts.removeAt(index);  // Actualizar lista original
    } catch (e) {
      hasError(true);
      errorMessage('Error deleting contact: ${e.toString()}');
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading(false);
    }
  }

  // Buscar contactos por nombre o teléfono
  void searchContact(String query) {
    if (query.isEmpty) {
      // Restaurar contactos originales si la búsqueda está vacía
      contacts.assignAll(originalContacts);
    } else {
      var filteredContacts = originalContacts.where((contact) {
        return contact['name'].toLowerCase().contains(query.toLowerCase()) ||
            contact['surname'].toLowerCase().contains(query.toLowerCase()) ||
            contact['phone'].toLowerCase().contains(query.toLowerCase()) ||
            contact['mobile'].toLowerCase().contains(query.toLowerCase());
      }).toList();
      contacts.assignAll(filteredContacts);
    }
  }
}
