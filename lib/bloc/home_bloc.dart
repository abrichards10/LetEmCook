import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:let_em_cook/bloc/home_repository.dart';

part 'home_events.dart';
part 'home_states.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  HomeBloc({required HomeRepository homeRepository}) : super(HomeStates()) {
    on<ToggleIngredientEvent>((event, emit) async {
      emit(ToggleIngredientState(ingredient: event.ingredient));
    });

    on<InitialEvent>((event, emit) async {
      emit(InitialState());
    });

    on<NoRecipesFoundEvent>((event, emit) async {
      emit(NoRecipesFoundState());
    });
  }
}
