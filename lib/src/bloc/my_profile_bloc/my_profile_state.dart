part of 'my_profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();
}


/// GetProfile
class MyProfileInitial extends MyProfileState {
  @override
  List<Object> get props => [];
}

class MyProfileLoading extends MyProfileState {
  @override
  List<Object> get props => [];
}

class MyProfileLoaded extends MyProfileState {
  final MyProfileScreenResponse myProfileScreenResponse;
  const MyProfileLoaded({required this.myProfileScreenResponse});
  @override
  List<Object> get props => [myProfileScreenResponse];
}

///EditProfile
class MyEditProfileInitial extends MyProfileState {
  @override
  List<Object> get props => [];
}

class MyEditProfileLoading extends MyProfileState {
  @override
  List<Object> get props => [];
}

// class MyEditProfileLoaded extends MyProfileState {
//   final EditProfileRequestResponse editProfileRequestResponse;
//   MyEditProfileLoaded({required this.editProfileRequestResponse});
//   @override
//   List<Object> get props => [editProfileRequestResponse];
// }