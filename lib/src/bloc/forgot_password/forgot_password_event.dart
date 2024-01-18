part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}


class ForgotPasswordEmailRequestEvent extends ForgotPasswordEvent {
  final ForgotPasswordEmailRequest forgotPasswordEmailRequest;
  const ForgotPasswordEmailRequestEvent({required this.forgotPasswordEmailRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [forgotPasswordEmailRequest];

}



class ForgotPasswordOtpRequestEvent extends ForgotPasswordEvent {
  final ForgotPasswordOtpRequest forgotPasswordOtpRequest;
  const ForgotPasswordOtpRequestEvent({required this.forgotPasswordOtpRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [forgotPasswordOtpRequest];

}

class ForgotPasswordResetRequestEvent extends ForgotPasswordEvent {
  final ForgotPasswordResetRequest forgotPasswordResetRequest;
  const ForgotPasswordResetRequestEvent({required this.forgotPasswordResetRequest});
  @override
  // TODO: implement props
  List<Object?> get props => [forgotPasswordResetRequest];

}