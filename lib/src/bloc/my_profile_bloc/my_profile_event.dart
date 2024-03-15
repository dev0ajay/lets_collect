part of 'my_profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();
}

///GetProfile

class GetProfileDataEvent extends MyProfileEvent {
  @override
  List<Object?> get props => [];

}


/// EditProfile

class EditProfileDataEvent extends MyProfileEvent {
  final EditProfileRequest editProfileRequest;
  const EditProfileDataEvent({required this.editProfileRequest});
  @override
  List<Object?> get props => [];

}