import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/characters_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/widgets/featured_characters_section.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/widgets/characters_grid_section.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/custom_loading_indicatos.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/custom_search_field.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/empty_state.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/error_widget.dart';
import 'package:flutter_marvel_characters/src/shared/widgets/section_header.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      listener: _handleStateChanges,
      child: Scaffold(
        body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) => _buildBody(context, state),
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, CharactersState state) {
    if (state is CharacterRefreshFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Refresh failed: ${state.errorMessage}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, CharactersState state) {
    return switch (state) {
      CharacterInitial() => _buildInitialContent(),
      CharacterLoading() => const CustomLoadingIndicator(),
      CharactersLoaded(:final filteredCharacters, :final characters) =>
        _buildMainContent(
          context,
          allCharacters: characters,
          filteredCharacters: filteredCharacters,
        ),
      CharacterRefreshing(:final currentCharacters) => _buildMainContent(
          context,
          allCharacters: currentCharacters,
          filteredCharacters: currentCharacters,
          isRefreshing: true,
        ),
      CharacterRefreshSuccess(:final characters) => _buildMainContent(
          context,
          allCharacters: characters,
          filteredCharacters: characters,
        ),
      CharacterRefreshFailure(:final currentCharacters, :final errorMessage) =>
        _buildMainContent(
          context,
          allCharacters: currentCharacters,
          filteredCharacters: currentCharacters,
          showError: true,
          errorMessage: errorMessage,
        ),
      CharacterError(:final message) => CustomErrorWidget(
          message: message,
          onRetry: () =>
              context.read<CharactersBloc>().add(const FetchCharactersEvent()),
        ),
    };
  }

  Widget _buildInitialContent() {
    return const EmptyStateWidget(
      icon: Icons.people,
      message: 'Pull down to load characters',
    );
  }

  Widget _buildMainContent(
    BuildContext context, {
    required List<CharacterEntity> allCharacters,
    required List<CharacterEntity> filteredCharacters,
    bool isRefreshing = false,
    bool showError = false,
    String errorMessage = '',
  }) {
    final featuredCharacters = allCharacters.take(3).toList();

    return RefreshIndicator(
      color: Colors.red,
      onRefresh: () async {
        context.read<CharactersBloc>().add(const RefreshCharactersEvent());
      },
      child: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          _buildFeaturedSection(featuredCharacters),
          _buildCharactersListSection(context, filteredCharacters),
          if (isRefreshing) _buildLoadingIndicator(),
          if (showError) _buildErrorBanner(context, errorMessage),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(BuildContext context) {
    const Color appBarDarkColor = Color(0xFF1F1F1F);

    return SliverAppBar(
      backgroundColor: appBarDarkColor,

      foregroundColor: Theme.of(context).colorScheme.onPrimary,

      expandedHeight: 120,
      floating: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/marvel-logo.png', 
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildFeaturedSection(List<CharacterEntity> characters) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: FeaturedCharactersSection(featuredCharacters: characters),
      ),
    );
  }

  SliverList _buildCharactersListSection(
    BuildContext context,
    List<CharacterEntity> characters,
  ) {
    return SliverList(
      delegate: SliverChildListDelegate([
        SectionHeader(
          title: 'MARVEL CHARACTERS LIST',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomSearchField(
            onChanged: (value) {
              context.read<CharactersBloc>().add(FilterCharacterEvent(value));
            },
          ),
        ),
        if (characters.isEmpty)
          const EmptyStateWidget()
        else
          CharactersGridSection(characters: characters),
      ]),
    );
  }

  SliverToBoxAdapter _buildLoadingIndicator() {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CustomLoadingIndicator(),
      ),
    );
  }

  SliverToBoxAdapter _buildErrorBanner(
      BuildContext context, String errorMessage) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        color: Colors.red[900],
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Refresh failed: $errorMessage',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 20, color: Colors.white),
              onPressed: () {
                context
                    .read<CharactersBloc>()
                    .add(const ClearRefreshErrorEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
