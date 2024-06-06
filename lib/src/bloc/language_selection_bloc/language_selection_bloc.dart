import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/language_selection/language_selection_request.dart';
import 'package:lets_collect/src/model/language_selection/language_selection_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

part 'language_selection_event.dart';
part 'language_selection_state.dart';

class LanguageSelectionBloc extends Bloc<LanguageSelectionEvent, LanguageSelectionState> {
  final ProfileScreenProvider profileScreenProvider;
  LanguageSelectionBloc({required this.profileScreenProvider}) : super(LanguageSelectionInitial()) {
    on<LanguageSelectionEventRequest>((event, emit) async{
     emit(LanguageSelectionLoading());
     final StateModel? stateModel = await profileScreenProvider.languageSelection(event.languageSelectionRequest);
     if(stateModel is SuccessState) {
       emit(LanguageSelectionLoaded(languageSelectionResponse: stateModel.value));
     }else {
       emit(LanguageSelectionError());
     }
    });
  }
}
