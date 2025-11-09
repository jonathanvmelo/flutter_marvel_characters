// featured_character_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/network_image_with_placeholder.dart';

class FeaturedCharacterCard extends StatelessWidget {
  final CharacterEntity character;

  const FeaturedCharacterCard({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            NetworkImageWithPlaceholder(
              imageUrl: character.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(16),
              placeholder: const _MarvelPlaceholder(),
              errorWidget: const _MarvelErrorWidget(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black87,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  character.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MarvelPlaceholder extends StatelessWidget {
  const _MarvelPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: const Center(
        child: Icon(
          Icons.auto_awesome,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}

class _MarvelErrorWidget extends StatelessWidget {
  const _MarvelErrorWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.heart_broken,
              color: Colors.red,
              size: 32,
            ),
            SizedBox(height: 8),
            Text(
              'Hero not found',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
