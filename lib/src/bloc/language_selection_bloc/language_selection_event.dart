part of 'language_selection_bloc.dart';

sealed class LanguageSelectionEvent extends Equatable {
  const LanguageSelectionEvent();
}
class LanguageSelectionEventRequest extends LanguageSelectionEvent {
  final LanguageSelectionRequest languageSelectionRequest;
  const LanguageSelectionEventRequest({required this.languageSelectionRequest});
  @override
  List<Object?> get props => [];
}