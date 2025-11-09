import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/section_header.dart';
import 'feature_character_card.dart';

class FeaturedCharactersSection extends StatelessWidget {
  final List<CharacterEntity> featuredCharacters;

  const FeaturedCharactersSection({
    super.key,
    required this.featuredCharacters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(title: 'FEATURED CHARACTERS'),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              for (final character in featuredCharacters) ...[
                FeaturedCharacterCard(character: character),
                const SizedBox(width: 12),
              ]
            ],
          ),
        ),
      ],
    );
  }
}