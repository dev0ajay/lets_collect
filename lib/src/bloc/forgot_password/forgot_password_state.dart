part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}
///Forgot password email state
class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final ForgotPasswordEmailRequestResponse forgotPasswordEmailRequestResponse;
  const ForgotPasswordLoaded({required this.forgotPasswordEmailRequestResponse});
  @override
  List<Object> get props => [forgotPasswordEmailRequestResponse];
}

class ForgotPasswordLoadingError extends ForgotPasswordState {
  final String errorMsg;
  const ForgotPasswordLoadingError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class ForgotPasswordLoadingTimeOutError extends ForgotPasswordState {
  final String errorMsg;
  const ForgotPasswordLoadingTimeOutError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
class ForgotPasswordLoadingBadRequest extends ForgotPasswordState {
  final String errorMsg;
  const ForgotPasswordLoadingBadRequest({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
class ForgotPasswordLoadingNotFound extends ForgotPasswordState {
  final String errorMsg;
  const ForgotPasswordLoadingNotFound({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}
///Forgot password otp state

class ForgotPasswordOtpLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordOtpLoaded extends ForgotPasswordState {
  final ForgotPasswordOtpRequestResponse forgotPasswordOtpRequestResponse;
  const ForgotPasswordOtpLoaded({required this.forgotPasswordOtpRequestResponse});
  @override
  List<Object> get props => [forgotPasswordOtpRequestResponse];
}


///Forgot password otp state

class ForgotPasswordResetLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class ForgotPasswordResetLoaded extends ForgotPasswordState {
  final ForgotPasswordResetRequestResponse forgotPasswordResetRequestResponse;
  const ForgotPasswordResetLoaded({required this.forgotPasswordResetRequestResponse});
  @override
  List<Object> get props => [forgotPasswordResetRequestResponse];
}