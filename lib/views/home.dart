import 'package:flutter/material.dart';
import '../controllers/crud_services.dart';
import '../controllers/auth_services.dart';
import 'add_contact_page.dart';
import 'update_contact.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final crud = CrudServices();
    final auth = AuthServices();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            onPressed: () async {
              await auth.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),

      // 📋 LIST CONTACT
      body: StreamBuilder(
        stream: crud.getContacts(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No contacts yet"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    //  AVATAR
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEAD3C8),
                      child: Text(
                        data['name'][0].toUpperCase(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),

                    //  NAME
                    title: Text(
                      data['name'],
                      style:
                          const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    //  PHONE
                    subtitle: Text(data['phone']),
                    //  ICON
                    trailing: const Icon(Icons.edit),

                    //  CLICK → UPDATE
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UpdateContactPage(
                            id: data.id,
                            name: data['name'],
                            phone: data['phone'],
                          ),
                        ),
                      );
                    },

                    onLongPress: () async {
                      await crud.deleteContact(data.id);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Deleted")),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      //  ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFEAD3C8),
        child: const Icon(Icons.person_add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddContactPage(),
            ),
          );
        },
      ),
    );
  }
}