part of 'home_bloc.dart';

class IngredientState extends Equatable {
  final Set<int> pressedIndices;

  const IngredientState({this.pressedIndices = const <int>{}});

  @override
  List<Object> get props => [pressedIndices];
}
