
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_event.dart';
import 'package:lets_collect/src/bloc/language/language_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

const languagePrefsKey = 'languagePrefs';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
    on<GetLanguage>(onGetLanguage);
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      languagePrefsKey,
      event.selectedLanguage.value.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }

  onGetLanguage(GetLanguage event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final selectedLanguage = prefs.getString(languagePrefsKey);
    emit(state.copyWith(
      selectedLanguage: selectedLanguage != null
          ? Language.values
          .where((item) => item.value.languageCode == selectedLanguage)
          .first
          : Language.english,
    ));
  }
}