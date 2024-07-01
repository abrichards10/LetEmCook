part of 'home_bloc.dart';

class HomeStates extends Equatable {
  final Set<int> pressedIndices;

  const HomeStates({this.pressedIndices = const <int>{}});

  @override
  List<Object> get props => [pressedIndices];
}

class InitialState extends HomeStates {
  const InitialState();
}

class NoRecipesFoundState extends HomeStates {
  const NoRecipesFoundState();
}

class ToggleIngredientState extends HomeStates {
  const ToggleIngredientState();
}
