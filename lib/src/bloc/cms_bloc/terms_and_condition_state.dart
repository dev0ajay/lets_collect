part of 'terms_and_condition_bloc.dart';

abstract class TermsAndConditionState extends Equatable {
  const TermsAndConditionState();
}

class TermsAndConditionInitial extends TermsAndConditionState {
  @override
  List<Object> get props => [];
}

class TermsAndConditionLoading extends TermsAndConditionState {
  @override
  List<Object> get props => [];
}

class TermsAndConditionLoaded extends TermsAndConditionState {
  final TermsAndConditionResponse termsAndConditionResponse;
  const TermsAndConditionLoaded({required this.termsAndConditionResponse});
  @override
  List<Object> get props => [termsAndConditionResponse];
}