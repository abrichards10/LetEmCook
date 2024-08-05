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
  final List<String> selectedIngredients;

  ToggleIngredientState(
      {required this.ingredient, required this.selectedIngredients});

  List<Object> get props => [ingredient, selectedIngredients];
}
