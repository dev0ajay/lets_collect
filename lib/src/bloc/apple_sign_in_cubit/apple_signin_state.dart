part of 'apple_signin_cubit.dart';

@immutable
abstract class AppleSignInState {}

class AppleSignInInitial extends AppleSignInState {}
class AppleSignInLoading extends AppleSignInState {}
class AppleSignInLoaded extends AppleSignInState {
  final User user;
  AppleSignInLoaded({required this.user});
}
class AppleSignInDenied extends AppleSignInState {}
class AppleSignInError extends AppleSignInState {}
