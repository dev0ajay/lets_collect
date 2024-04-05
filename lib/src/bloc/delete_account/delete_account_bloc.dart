
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/profile/delete_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../resources/api_providers/profile_screen_provider.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  ProfileDataProvider profileDataProvider;
  DeleteAccountBloc({required this.profileDataProvider}) : super(DeleteAccountInitial()) {
    on<DeleteAccountEventTrigger>((event, emit) async{
      emit(DeleteAccountLoading());
      final StateModel? stateModel = await profileDataProvider.deleteAccount();
      if(stateModel is SuccessState) {
        emit(DeleteAccountLoaded(deleteAccountRequestResponse: stateModel.value));
      }
    });
  }
}
