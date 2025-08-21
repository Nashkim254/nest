// ticket_tier_model.dart
import 'package:flutter/material.dart';

class TicketTier {
  final String id;
  final TextEditingController tierNameController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController descriptionController;
  final TextEditingController passwordController;

  bool isRequireApproval;
  bool isPasswordProtected;
  bool isTransferable;

  TicketTier({
    required this.id,
    this.isRequireApproval = false,
    this.isPasswordProtected = false,
    this.isTransferable = false,
  })  : tierNameController = TextEditingController(),
        priceController = TextEditingController(),
        quantityController = TextEditingController(),
        descriptionController = TextEditingController(),
        passwordController = TextEditingController();

  // Generate unique ID
  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Dispose all controllers
  void dispose() {
    tierNameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    passwordController.dispose();
  }

  // Convert to Map for API calls
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tierName': tierNameController.text,
      'price': double.tryParse(priceController.text) ?? 0.0,
      'quantity': int.tryParse(quantityController.text) ?? 0,
      'description': descriptionController.text,
      'password': passwordController.text,
      'requireApproval': isRequireApproval,
      'passwordProtected': isPasswordProtected,
      'transferable': isTransferable,
    };
  }
}
