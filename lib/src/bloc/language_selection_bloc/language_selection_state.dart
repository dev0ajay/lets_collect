part of 'language_selection_bloc.dart';

sealed class LanguageSelectionState extends Equatable {
  const LanguageSelectionState();
}

final class LanguageSelectionInitial extends LanguageSelectionState {
  @override
  List<Object> get props => [];
}
final class LanguageSelectionLoading extends LanguageSelectionState {
  @override
  List<Object> get props => [];
}
final class LanguageSelectionLoaded extends LanguageSelectionState {
  final LanguageSelectionResponse languageSelectionResponse;
  const LanguageSelectionLoaded({required this.languageSelectionResponse});
  @override
  List<Object> get props => [languageSelectionResponse];
}
final class LanguageSelectionError extends LanguageSelectionState {
  @override
  List<Object> get props => [];
}