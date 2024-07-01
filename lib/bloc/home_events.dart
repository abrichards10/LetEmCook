part of 'home_bloc.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();

  @override
  List<Object> get props => [];
}

class InitialEvent extends HomeEvents {}

class NoRecipesFoundEvent extends HomeEvents {}

class ToggleIngredientEvent extends HomeEvents {}
