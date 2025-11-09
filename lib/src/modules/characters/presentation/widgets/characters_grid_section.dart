import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'characters_card.dart';

class CharactersGridSection extends StatelessWidget {
  final List<CharacterEntity> characters;

  const CharactersGridSection({
    super.key,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.0,
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          return CharacterCard(character: character);
        },
      ),
    );
  }
}