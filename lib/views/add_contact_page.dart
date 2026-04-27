import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final phone = TextEditingController();
    final email = TextEditingController();

    final crud = CrudServices();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: name, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: phone, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: email, decoration: const InputDecoration(labelText: "Email")),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await crud.addContact(name.text, phone.text, email.text);
                Navigator.pop(context);
              },
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}