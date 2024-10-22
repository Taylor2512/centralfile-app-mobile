import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test01/app/modules/contact_module/contact_controller.dart';

import 'AddEditContactPage.dart';

class ContactPage extends StatelessWidget {
  final ContactController contactController = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactos'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Mostrar diálogo de búsqueda
              showSearch(context: context, delegate: ContactSearch(contactController));
            },
          )
        ],
      ),
      body: Obx(() {
        // Estado de carga
        if (contactController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Manejo de errores
        if (contactController.hasError.value) {
          return Center(
            child: Text(
              'Error: ${contactController.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Si no hay contactos
        if (contactController.contacts.isEmpty) {
          return const Center(child: Text('No hay contactos registrados.'));
        }

        // Mostrar lista de contactos
        return ListView.builder(
          itemCount: contactController.contacts.length,
          itemBuilder: (context, index) {
            var contact = contactController.contacts[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: contact['photo'] != null
                    ? NetworkImage(contact['photo'])
                    : null,
                child: contact['photo'] == null ? Icon(Icons.person) : null,
              ),
              title: Text('${contact['name']} ${contact['surname']}'),
              subtitle: Text('Teléfono: ${contact['phone']} \nCelular: ${contact['mobile']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // Navegar a la página de edición de contacto
                      _navigateToEditContact(context, contact, index);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      contactController.deleteContact(index);
                    },
                  ),
                ],
              ),
              onTap: () {
                // Acciones al tocar el contacto, si es necesario
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Navegar a la página de agregar contacto
          _navigateToAddContact(context);
        },
      ),
    );
  }

  void _navigateToAddContact(BuildContext context) {
    Get.to(() => AddEditContactPage());
  }

  void _navigateToEditContact(BuildContext context, dynamic contact, int index) {
    Get.to(() => AddEditContactPage(contact: contact, index: index));
  }
}

class ContactSearch extends SearchDelegate {
  final ContactController contactController;

  ContactSearch(this.contactController);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = contactController.contacts
        .where((contact) =>
    contact['name'].toLowerCase().contains(query.toLowerCase()) ||
        contact['surname'].toLowerCase().contains(query.toLowerCase()) ||
        contact['phone'].contains(query) ||
        contact['mobile'].contains(query))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var contact = results[index];
        return ListTile(
          title: Text('${contact['name']} ${contact['surname']}'),
          subtitle: Text('Teléfono: ${contact['phone']}'),
          onTap: () {
            close(context, contact);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
