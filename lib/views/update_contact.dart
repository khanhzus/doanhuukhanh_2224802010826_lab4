import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class UpdateContactPage extends StatelessWidget {
  final String id;
  final String name;
  final String phone;

  const UpdateContactPage({
    super.key,
    required this.id,
    required this.name,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    final crud = CrudServices();

    TextEditingController nameController =
        TextEditingController(text: name);
    TextEditingController phoneController =
        TextEditingController(text: phone);

    return Scaffold(
      appBar: AppBar(title: const Text("Update Contact")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Phone"),
            ),

            const SizedBox(height: 20),

            //  UPDATE
            ElevatedButton(
              onPressed: () async {
                await crud.updateContact(
                  id,
                  nameController.text,
                  phoneController.text,
                );

                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),

            const SizedBox(height: 10),

            //  DELETE
            OutlinedButton(
              onPressed: () async {
                await crud.deleteContact(id);

                Navigator.pop(context);
              },
              child: const Text("Delete"),
            )
          ],
        ),
      ),
    );
  }
}