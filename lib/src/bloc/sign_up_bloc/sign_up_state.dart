part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}
class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}
class SignUpLoaded extends SignUpState {
  final SignUpRequestResponse signUpRequestResponse;
  const SignUpLoaded({required this.signUpRequestResponse});
  @override
  List<Object> get props => [signUpRequestResponse];
}
class SignUpErrorState extends SignUpState {
  final SignUpRequestErrorResponse signUpRequestErrorResponse;
  const SignUpErrorState({required this.signUpRequestErrorResponse});
  @override
  List<Object> get props => [signUpRequestErrorResponse];
}

class SignUpLoadingServerError extends SignUpState {
  final String errorMsg;
  const SignUpLoadingServerError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
class SignUpLoadingTimeoutError extends SignUpState {
  final String errorMsg;
  const SignUpLoadingTimeoutError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
class SignUpLoadingConnectionRefusedError extends SignUpState {
  final String errorMsg;
  const SignUpLoadingConnectionRefusedError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}