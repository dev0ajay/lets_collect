part of 'google_sign_in_cubit.dart';

@immutable
abstract class GoogleSignInState {}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInCubitLoading extends GoogleSignInState {}

class GoogleSignInLoggedOut extends GoogleSignInState {}

class GoogleSignInSuccess extends GoogleSignInState {
  final User user;

  GoogleSignInSuccess({required this.user});
}

class GoogleSignInError extends GoogleSignInState {}
