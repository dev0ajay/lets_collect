
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/auth/response.dart';
import '../../model/auth/sign_up_error_response_model.dart';
import '../../model/auth/sign_up_request.dart';
import '../../model/state_model.dart';
import '../../resources/api_providers/auth_provider.dart';
part 'sign_up_state.dart';
part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthDataProvider authProvider;
  SignUpBloc({required this.authProvider}) : super(SignUpInitial()) {
    on<SignUpRequestEvent>((event, emit) async {
      // SignupRequest? signupRequest;
      emit(SignUpLoading());
      final StateModel? stateModel = await authProvider.registerUser(event.signupRequest);
      // final StateModel? errorModel = await authProvider.registerUser(event.signupRequest);

      if (stateModel is SuccessState) {
        emit(SignUpLoaded(signUpRequestResponse: stateModel.value));
      }
      if(stateModel is ErrorState) {
        emit(SignUpErrorState(signUpRequestErrorResponse: stateModel.msg));
        emit(SignUpLoadingServerError(errorMsg: stateModel.msg));
        emit(SignUpLoadingTimeoutError(errorMsg: stateModel.msg));
        emit(SignUpLoadingConnectionRefusedError(errorMsg: stateModel.msg));
      }
    });
  }
}
