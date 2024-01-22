import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final db = FirebaseFirestore.instance;
  var name = 'gigih'.obs;
  TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    getName();
    super.onInit();
  }

  void getName() async {
    final data = await db.collection('users').doc('1').get();
    name.value = data['name'] ?? 'gigih';
  }

  void updateName() async {
    try {
      await db.collection('users').doc('1').set({
        'name': nameController.text,
      });
      name.value = nameController.text;
      // Get.back();
      nameController.clear();
      Get.snackbar(
        'Success',
        'Name updated successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
