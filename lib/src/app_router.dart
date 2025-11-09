import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/controllers/character_details_bloc.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/pages/characters_details_page.dart';
import 'package:flutter_marvel_characters/src/modules/characters/presentation/pages/characters_page.dart';
import 'package:flutter_marvel_characters/src/sl.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const CharactersPage();
      },
      routes: <RouteBase>[
        // ==========================================================
        // Rota 1: Characters Details Page (Root Path)
        // ==========================================================
        GoRoute(
          path: 'character/:id',
          name: 'character_details',
          builder: (context, state) {
            final characterId = int.parse(state.pathParameters['id']!);
            return BlocProvider(
              create: (context) => sl<CharacterDetailsBloc>()
                ..add(FetchCharacterDetailsEvent(characterId)),
              child: const CharacterDetailsPage(),
            );
          },
        ),
      ],
    ),
  ],
  // errorBuilder: (context, state) => Scaffold(
  //   body: Center(
  //     child: Text('Error: ${state.error}'),
  //   ),
  // ),
);
