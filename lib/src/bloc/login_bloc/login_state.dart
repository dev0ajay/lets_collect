part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginLoaded extends LoginState {
  final LoginRequestResponse loginRequestResponse;
  const LoginLoaded({required this.loginRequestResponse});
  @override
  List<Object> get props => [loginRequestResponse];
}