part of 'delete_account_bloc.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();
}

class DeleteAccountEventTrigger extends DeleteAccountEvent{
  @override
  List<Object?> get props => [];
}