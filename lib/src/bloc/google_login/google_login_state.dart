part of 'google_login_bloc.dart';

abstract class GoogleLoginState extends Equatable {
  const GoogleLoginState();
}

class GoogleLoginInitial extends GoogleLoginState {
  @override
  List<Object> get props => [];
}

class GoogleLoginLoading extends GoogleLoginState {
  @override
  List<Object> get props => [];
}

class GoogleLoginLoaded extends GoogleLoginState {
  final GoogleLoginResponse googleLoginResponse;
  const GoogleLoginLoaded({required this.googleLoginResponse});
  @override
  List<Object> get props => [googleLoginResponse];
}

class GoogleLoginErrorState extends GoogleLoginState {
  final String msg;
  const GoogleLoginErrorState({required this.msg});
  @override
  List<Object> get props => [msg];
}