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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return TextField(
      style: TextStyle(color: colorScheme.onBackground),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:
            Icon(Icons.search, color: colorScheme.onBackground.withOpacity(0.7)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      ),
      onChanged: onChanged,
    );
  }
}
