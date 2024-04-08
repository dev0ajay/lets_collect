import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/facebook_sign_in_request.dart';
import 'package:lets_collect/src/model/auth/facebook_sign_in_response.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/model/auth/login_request_response.dart';
import '../../model/auth/apple_signin_request.dart';
import '../../model/auth/apple_signin_request_response.dart';
import '../../model/auth/google_login_request.dart';
import '../../model/auth/google_login_response.dart';
import '../../model/state_model.dart';
import '../../resources/api_providers/auth_provider.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataProvider authProvider;

  LoginBloc({required this.authProvider}) : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      emit(LoginLoading());

      final StateModel? stateModel =
          await authProvider.loginRequest(event.loginRequest);
      if (stateModel is SuccessState) {
        emit(LoginLoaded(loginRequestResponse: stateModel.value));
      }
      if (stateModel is ErrorState) {
        emit(LoginLoadingServerError(errorMsg: stateModel.msg));
        emit(LoginLoadingRequestTimeOut(errorMsg: stateModel.msg));
        emit(LoginLoadingConnectionRefused(errorMsg: stateModel.msg));
      }
    });
    ///Google
    on<GetGoogleLoginEvent>((event, emit) async {
      emit(GoogleLoginLoading());
      final StateModel? stateModel =
      await authProvider.googleLogin(event.googleLoginRequest);
      if (stateModel is SuccessState) {
        emit(GoogleLoginLoaded(googleLoginResponse: stateModel.value));
      } else if (stateModel is ErrorState) {
        emit(GoogleLoginErrorState(msg: stateModel.msg));
      }
    });

    ///Apple
    on<AppleSignInEvent>((event, emit) async{
      emit(SignInWithAppleLoading());
      final StateModel? stateModel = await authProvider.signInWithApple(event.appleSignInRequest);
      if(stateModel is SuccessState) {
        emit(SignInWithAppleLoaded(appleSignInRequestResponse: stateModel.value));
      }else if(stateModel is ErrorState) {
        emit(SignInWithAppleError(errorMsg: stateModel.msg));
      }
    });


    ///Facebook
    on<FacebookSignInEvent>((event, emit) async{
      emit(SignInWithFacebookLoading());
      final StateModel? stateModel = await authProvider.signInWithFacebook(event.facebookSignInRequest);
      if(stateModel is SuccessState) {
        emit(SignInWithFacebookLoaded(facebookSignInResponse: stateModel.value,));
      }else if(stateModel is ErrorState) {
        emit(SignInWithFacebookError(errorMsg: stateModel.msg));
      }
    });
  }
}
