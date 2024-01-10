part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginRequestEvent extends LoginEvent{
  final LoginRequest loginRequest;
  const LoginRequestEvent({required this.loginRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [loginRequest];

}