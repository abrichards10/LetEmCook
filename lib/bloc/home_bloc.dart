import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:let_em_cook/bloc/home_repository.dart';

part 'home_events.dart';
part 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  List<String> selectedIngredients = [];

  HomeBloc({required HomeRepository homeRepository}) : super(HomeStates()) {
    on<ToggleIngredientEvent>((event, emit) async {
      if (selectedIngredients.contains(event.ingredient)) {
        selectedIngredients.remove(event.ingredient);
      } else {
        selectedIngredients.add(event.ingredient);
      }
      emit(ToggleIngredientState(
          ingredient: event.ingredient,
          selectedIngredients: List.from(selectedIngredients)));
    });

    on<InitialEvent>((event, emit) async {
      emit(InitialState());
    });

    on<NoRecipesFoundEvent>((event, emit) async {
      emit(NoRecipesFoundState());
    });
  }
}
