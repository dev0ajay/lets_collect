part of 'google_login_bloc.dart';

abstract class GoogleLoginEvent extends Equatable {
  const GoogleLoginEvent();
}

class GetGoogleLoginEvent extends GoogleLoginEvent {
  final GoogleLoginRequest googleLoginRequest;
  const GetGoogleLoginEvent({required this.googleLoginRequest});
  @override
  List<Object?> get props => [googleLoginRequest];

}