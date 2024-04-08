part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
}

class GetChangePasswordEvent extends ChangePasswordEvent{
  final ChangePasswordRequest changePasswordRequest;
  const GetChangePasswordEvent({required this.changePasswordRequest});
  @override
  List<Object?> get props => [changePasswordRequest];

}