part of 'home_bloc.dart';

class HomeStates {}

class InitialState extends HomeStates {
  InitialState();
}

class NoRecipesFoundState extends HomeStates {
  NoRecipesFoundState();
}

class ToggleIngredientState extends HomeStates {
  final String ingredient;

  ToggleIngredientState({required this.ingredient});
}
