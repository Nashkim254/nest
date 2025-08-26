import 'package:flutter/material.dart';

class CreateEventFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const CreateEventFAB({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: const Color(0xFFFF6B35),
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Create New Event',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
