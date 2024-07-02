import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_em_cook/bloc/home_bloc.dart';
import 'package:let_em_cook/bloc/home_repository.dart';
import 'package:let_em_cook/navigation.dart';
import 'package:let_em_cook/intro_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                HomeBloc(homeRepository: HomeRepository())..add(InitialEvent()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: IntroScreen(),
        ),
      ),
    );
  }
}
