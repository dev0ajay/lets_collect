
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

import '../../model/change_password/change_password_request.dart';
import '../../model/change_password/change_password_request_response.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ProfileScreenProvider myProfileDataProvider;
  ChangePasswordBloc({required this.myProfileDataProvider}) : super(ChangePasswordInitial()) {
    on<GetChangePasswordEvent>((event, emit) async{
      emit(ChangePasswordLoading());
      final StateModel? stateModel =  await myProfileDataProvider.getChangePasswordData(event.changePasswordRequest);
      if(stateModel is SuccessState) {
        emit(ChangePasswordLoaded(changePasswordRequestResponse: stateModel.value));
      }
    });
  }
}