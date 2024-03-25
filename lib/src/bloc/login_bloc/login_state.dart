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



class LoginLoadingServerError extends LoginState {
  final String errorMsg;
  const LoginLoadingServerError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}



class LoginLoadingRequestTimeOut extends LoginState {
  final String errorMsg;
  const LoginLoadingRequestTimeOut({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}



class LoginLoadingConnectionRefused extends LoginState {
  final String errorMsg;
  const LoginLoadingConnectionRefused({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

///Google
class GoogleLoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class GoogleLoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class GoogleLoginLoaded extends LoginState {
  final GoogleLoginResponse googleLoginResponse;
  const GoogleLoginLoaded({required this.googleLoginResponse});
  @override
  List<Object> get props => [googleLoginResponse];
}

class GoogleLoginErrorState extends LoginState {
  final String msg;
  const GoogleLoginErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}

///Apple
class SignInWithAppleInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class SignInWithAppleLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class SignInWithAppleLoaded extends LoginState {
  final AppleSignInRequestResponse appleSignInRequestResponse;
  const SignInWithAppleLoaded({required this.appleSignInRequestResponse});
  @override
  List<Object> get props => [appleSignInRequestResponse];
}

class SignInWithAppleError extends LoginState {
  final String errorMsg;
  const SignInWithAppleError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}