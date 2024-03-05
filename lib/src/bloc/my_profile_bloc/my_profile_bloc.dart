import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lets_collect/src/model/edit_profile/edit_profile_request.dart';
import 'package:lets_collect/src/model/my_profile/my_profile_screen_response.dart';
import 'package:lets_collect/src/model/state_model.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

import '../../model/edit_profile/edit_profile_request_response.dart';

part 'my_profile_event.dart';

part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final MyProfileDataProvider myProfileDataProvider;

  MyProfileBloc({required this.myProfileDataProvider})
      : super(MyProfileInitial()) {
    on<GetProfileDataEvent>((event, emit) async {
      emit(MyProfileLoading());

      final StateModel? stateModel =
          await myProfileDataProvider.getProfileData();
      if (stateModel is SuccessState) {
        emit(MyProfileLoaded(myProfileScreenResponse: stateModel.value));
      }
    });

    on<EditProfileDataEvent>(
      (event, emit) async {
        emit(MyEditProfileLoading());
        final StateModel? stateModel = await myProfileDataProvider
            .getEditProfileData(event.editProfileRequest);
        if (stateModel is SuccessState) {
          emit(MyEditProfileLoaded(
              editProfileRequestResponse: stateModel.value));
        }
      },
    );
  }
}
