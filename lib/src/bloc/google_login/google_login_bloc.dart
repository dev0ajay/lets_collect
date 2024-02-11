
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/google_login_request.dart';
import 'package:lets_collect/src/model/auth/google_login_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/auth_provider.dart';

part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final AuthProvider authProvider;
  GoogleLoginBloc({required this.authProvider}) : super(GoogleLoginInitial()) {
    on<GetGoogleLoginEvent>((event, emit) async{
      emit(GoogleLoginLoading());
      final StateModel? stateModel = await authProvider.googleLogin(event.googleLoginRequest);
      if(stateModel is SuccessState) {
        emit(GoogleLoginLoaded(googleLoginResponse: stateModel.value));

      }
    });
  }
}
