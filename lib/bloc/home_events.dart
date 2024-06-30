part of 'home_bloc.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object> get props => [];
}

class ToggleIngredientEvent extends IngredientEvent {
  final int index;

  const ToggleIngredientEvent(this.index);

  @override
  List<Object> get props => [index];
}
