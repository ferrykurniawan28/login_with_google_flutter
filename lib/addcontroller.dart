import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  final db = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void upload() async {
    try {
      final finalPrice =
          int.parse(quantityController.text) * int.parse(priceController.text);

      await db.collection('items').add({
        'name': nameController.text,
        'quantity': int.parse(quantityController.text),
        'price': int.parse(priceController.text),
        'finalPrice': finalPrice,
      });
      Get.back();
      Get.snackbar(
        'Success',
        'Item added successfully',
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
    quantityController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
