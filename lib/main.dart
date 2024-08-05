import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:let_em_cook/bloc/home_bloc.dart';
import 'package:let_em_cook/bloc/home_repository.dart';
import 'package:let_em_cook/intro_screen.dart';
import 'package:let_em_cook/groceries.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
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
        child: ChangeNotifierProvider(
          create: (context) => CartModel(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: IntroScreen(),
          ),
        ),
      ),
    );
  }
}
