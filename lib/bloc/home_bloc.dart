import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_events.dart';
part 'home_states.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  IngredientBloc() : super(IngredientState()) {
    on<ToggleIngredientEvent>((event, emit) {
      final updatedPressedIndices = Set<int>.from(state.pressedIndices);
      if (updatedPressedIndices.contains(event.index)) {
        updatedPressedIndices.remove(event.index);
      } else {
        updatedPressedIndices.add(event.index);
      }
      emit(IngredientState(pressedIndices: updatedPressedIndices));
    });
  }
}
