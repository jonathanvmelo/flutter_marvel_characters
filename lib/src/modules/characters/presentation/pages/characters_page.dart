import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/domain/entities/character_entity.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/characters_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/widgets/characters_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharactersBloc, CharactersState>(
      listener: (context, state) {
        _handleStateChanges(context, state);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marvel Characters'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                context
                    .read<CharactersBloc>()
                    .add(const RefreshCharactersEvent());
              },
            ),
          ],
        ),
        body: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            return _buildBody(state);
          },
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
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context
                  .read<CharactersBloc>()
                  .add(const ClearRefreshErrorEvent());
            },
          ),
        ),
      );
    }

    if (state is CharacterRefreshSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Characters updated successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildBody(CharactersState state) {
    return switch (state) {
      CharacterInitial() => const _InitialWidget(),
      CharacterLoading() => const _LoadingWidget(),
      CharacterLoaded(:final characters) =>
        _RefreshableCharactersList(characters: characters, isRefreshing: false),
      CharacterRefreshing(:final currentCharacters) =>
        _RefreshableCharactersList(
            characters: currentCharacters, isRefreshing: true),
      CharacterRefreshSuccess(:final characters) =>
        _RefreshableCharactersList(characters: characters, isRefreshing: false),
      CharacterRefreshFailure(:final currentCharacters, :final errorMessage) =>
        _RefreshableCharactersListWithError(
          characters: currentCharacters,
          errorMessage: errorMessage,
        ),
      CharacterError(:final message) => _ErrorWidget(message: message),
    };
  }
}

// ✅ WIDGETS QUE ESTAVAM FALTANDO

class _InitialWidget extends StatelessWidget {
  const _InitialWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Welcome to Marvel Characters',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Pull down to load characters',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading characters...'),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;

  const _ErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Failed to load characters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context
                    .read<CharactersBloc>()
                    .add(const FetchCharactersEvent());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RefreshableCharactersList extends StatelessWidget {
  final List<CharacterEntity> characters;
  final bool isRefreshing;

  const _RefreshableCharactersList({
    required this.characters,
    required this.isRefreshing,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CharactersBloc>().add(const RefreshCharactersEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      child: Stack(
        children: [
          if (characters.isEmpty)
            const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Center(
                heightFactor: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No characters found'),
                  ],
                ),
              ),
            )
          else
            ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return CharacterCard(character: character);
              },
            ),
          if (isRefreshing)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

class _RefreshableCharactersListWithError extends StatelessWidget {
  final List<CharacterEntity> characters;
  final String errorMessage;

  const _RefreshableCharactersListWithError({
    required this.characters,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CharactersBloc>().add(const RefreshCharactersEvent());
        await Future.delayed(const Duration(milliseconds: 1000));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.red[100],
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Refresh failed: $errorMessage',
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      context
                          .read<CharactersBloc>()
                          .add(const ClearRefreshErrorEvent());
                    },
                  ),
                ],
              ),
            ),
          ),
          if (characters.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No characters found'),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final character = characters[index];
                  return CharacterCard(character: character);
                },
                childCount: characters.length,
              ),
            ),
        ],
      ),
    );
  }
}
