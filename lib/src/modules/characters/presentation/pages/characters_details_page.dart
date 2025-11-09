import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_details_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/character_details_bloc.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/error_widget.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/network_image_with_placeholder.dart';
import 'package:flutter_marvel_characters/src/sl.dart';
import 'package:go_router/go_router.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<CharacterDetailsBloc, CharacterDetailsState>(
        listener: (context, state) {
          if (state is CharacterDetailsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return _buildBody(state, context);
        },
      ),
    );
  }

  Widget _buildBody(CharacterDetailsState state, BuildContext context) {
    return switch (state) {
      CharacterDetailsInitial() => _buildLoading(),
      CharacterDetailsLoading() => _buildLoading(),
      CharacterDetailsLoaded(:final character) =>
        _buildContent(character, context),
      CharacterDetailsError(:final message) => _buildError(message),
    };
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.red),
    );
  }

  Widget _buildError(String message) {
    return CustomErrorWidget(
      message: message,
      onRetry: () {
        final bloc = sl<CharacterDetailsBloc>();
        final currentState = bloc.state;
        if (currentState is CharacterDetailsError) {}
      },
    );
  }

  Widget _buildContent(CharacterDetailsEntity character, BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [StretchMode.zoomBackground],
            background: Stack(
              fit: StackFit.expand,
              children: [
                NetworkImageWithPlaceholder(
                  imageUrl: character.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pinned: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                character.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (character.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  character.description,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            _buildBiographySection(character),
            const SizedBox(height: 24),
            _buildStatsSection(character, context),
            const SizedBox(height: 32),
          ]),
        ),
      ],
    );
  }

  Widget _buildBiographySection(CharacterDetailsEntity character) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BIOGRAPHY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            character.biography.isNotEmpty
                ? character.biography
                : 'No biography available for this character.',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              height: 1.6,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(
      CharacterDetailsEntity character, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATISTICS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _buildStatItem('Comics', character.comicsCount, context),
              _buildStatItem('Series', character.seriesCount, context),
              _buildStatItem('Stories', character.storiesCount, context),
              _buildStatItem('Events', character.eventsCount, context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int count, BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              color: theme.scaffoldBackgroundColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: theme.scaffoldBackgroundColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
