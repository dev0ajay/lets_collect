
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/model/auth/login_request_response.dart';

import '../../model/state_model.dart';
import '../../resources/api_providers/auth_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthProvider authProvider;
  LoginBloc({required this.authProvider}) : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async{

      emit(LoginLoading());

      final StateModel? stateModel = await authProvider.loginRequest(event.loginRequest);
      if (stateModel is SuccessState) {
        emit(LoginLoaded(loginRequestResponse: stateModel.value));
      }

    });
  }
}
