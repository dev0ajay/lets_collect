part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoading extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordLoaded extends ChangePasswordState {
  final ChangePasswordRequestResponse changePasswordRequestResponse;
  const ChangePasswordLoaded({required this.changePasswordRequestResponse});
  @override
  List<Object> get props => [changePasswordRequestResponse];
}

class ChangePasswordError extends ChangePasswordState {
  final String errorMsg;
  const ChangePasswordError({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}