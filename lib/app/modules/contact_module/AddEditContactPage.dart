import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test01/app/modules/contact_module/contact_controller.dart';

class AddEditContactPage extends StatelessWidget {
  final ContactController contactController = Get.find<ContactController>();
  final dynamic contact;
  final int? index;

  AddEditContactPage({super.key, this.contact, this.index});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact['name'];
      surnameController.text = contact['surname'];
      phoneController.text = contact['phone'];
      mobileController.text = contact['mobile'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(contact == null ? 'Agregar Contacto' : 'Editar Contacto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(labelText: 'Apellido'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(labelText: 'Celular'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (contact == null) {
                  contactController.addContact({
                    'name': nameController.text,
                    'surname': surnameController.text,
                    'phone': phoneController.text,
                    'mobile': mobileController.text,
                  });
                } else {
                  contactController.updateContact(index!, {
                    'name': nameController.text,
                    'surname': surnameController.text,
                    'phone': phoneController.text,
                    'mobile': mobileController.text,
                  });
                }
                Get.back();
              },
              child: Text(contact == null ? 'Agregar' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
