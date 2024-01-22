import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_firebase/add.dart';
import 'package:tutor_firebase/profile.dart';

final db = FirebaseFirestore.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Get.to(() => const AddPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Get.to(() => const ProfilePage());
            },
          ),
        ],
      ),
      body: StreamBuilder(
          stream: db.collection('items').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // final data = snapshot.data as QuerySnapshot;
              final List data = snapshot.data!.docs;
              // print(data);
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    return Dismissible(
                      key: Key(doc.id),
                      onDismissed: (direction) async {
                        await db.collection('items').doc(doc.id).delete();
                        Get.snackbar(
                          'Success',
                          'Item deleted successfully',
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(data[index]['name']),
                          subtitle: Text(data[index]['quantity'].toString()),
                          // trailing: Text(doc['price'].toString()),
                          trailing: Text(data[index]['finalPrice'].toString()),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('No data found'),
              );
            }
            return Container();
          }),
    );
  }
}
