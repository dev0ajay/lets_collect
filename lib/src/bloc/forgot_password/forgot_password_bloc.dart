import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_response.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request_response.dart';
import 'package:lets_collect/src/model/state_model.dart';

import '../../model/auth/forgot_password_reset_request.dart';
import '../../model/auth/forgot_password_reset_request_response.dart';
import '../../resources/api_providers/auth_provider.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthProvider authProvider;
  ForgotPasswordBloc({required this.authProvider}) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailRequestEvent>((event, emit) async{

      emit(ForgotPasswordLoading());

      final StateModel? stateModel = await authProvider.forgotPassword(event.forgotPasswordEmailRequest);
      if(stateModel is SuccessState) {
        emit(ForgotPasswordLoaded(forgotPasswordEmailRequestResponse: stateModel.value));
      }
    });
///Forgot Password Otp event
    on<ForgotPasswordOtpRequestEvent>((event, emit) async{

      emit(ForgotPasswordOtpLoading());

      final StateModel? stateModel = await authProvider.forgotPasswordOtp(event.forgotPasswordOtpRequest);
      if(stateModel is SuccessState) {
        emit(ForgotPasswordOtpLoaded(forgotPasswordOtpRequestResponse: stateModel.value));
      }
    });

    ///Forgot Password Otp event
    on<ForgotPasswordResetRequestEvent>((event, emit) async{

      emit(ForgotPasswordResetLoading());

      final StateModel? stateModel = await authProvider.forgotPasswordReset(event.forgotPasswordResetRequest);
      if(stateModel is SuccessState) {
        emit(ForgotPasswordResetLoaded(forgotPasswordResetRequestResponse: stateModel.value));
      }
    });
    
  }
}
