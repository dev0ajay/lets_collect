part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpRequestEvent extends SignUpEvent{
  final SignupRequest signupRequest;
  const SignUpRequestEvent({required this.signupRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [signupRequest];

}
