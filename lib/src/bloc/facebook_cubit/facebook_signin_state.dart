part of 'facebook_signin_cubit.dart';

@immutable
abstract class FacebookSigninState {}

class FacebookSignInInitial extends FacebookSigninState {}
class FacebookSignInLoading extends FacebookSigninState {}
class FacebookSignInSuccess extends FacebookSigninState {
  final User user;
  FacebookSignInSuccess({required this.user});
}
class FacebookSignInDenied extends FacebookSigninState {}
class FacebookSignInError extends FacebookSigninState {}
