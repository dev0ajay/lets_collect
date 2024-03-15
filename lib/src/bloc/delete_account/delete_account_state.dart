part of 'delete_account_bloc.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();
}

class DeleteAccountInitial extends DeleteAccountState {
  @override
  List<Object> get props => [];
}


class DeleteAccountLoading extends DeleteAccountState {
  @override
  List<Object> get props => [];
}


class DeleteAccountLoaded extends DeleteAccountState {
  final DeleteAccountRequestResponse deleteAccountRequestResponse;
  const DeleteAccountLoaded({required this.deleteAccountRequestResponse});
  @override
  List<Object> get props => [deleteAccountRequestResponse];
}