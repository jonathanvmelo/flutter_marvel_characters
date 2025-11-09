import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomSearchField({
    super.key,
    required this.onChanged,
    this.hintText = 'Search characters',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onChanged: onChanged,
    );
  }
}