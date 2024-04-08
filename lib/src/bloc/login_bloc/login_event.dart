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
///Google
class GetGoogleLoginEvent extends LoginEvent {
  final GoogleLoginRequest googleLoginRequest;
  const GetGoogleLoginEvent({required this.googleLoginRequest});
  @override
  List<Object?> get props => [googleLoginRequest];

}

///Apple
class AppleSignInEvent extends LoginEvent {
  final AppleSignInRequest appleSignInRequest;
  const AppleSignInEvent({required this.appleSignInRequest});
  @override
  List<Object?> get props => [appleSignInRequest];
}
///Facebook
class FacebookSignInEvent extends LoginEvent {
  final FacebookSignInRequest facebookSignInRequest;
  const FacebookSignInEvent({required this.facebookSignInRequest});
  @override
  List<Object?> get props => [facebookSignInRequest];
}