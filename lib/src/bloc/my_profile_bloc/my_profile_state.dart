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

class MyProfileErrorState extends MyProfileState {
  final String errorMsg;
  const MyProfileErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
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

class MyEditProfileLoaded extends MyProfileState {
  final EditProfileRequestResponse editProfileRequestResponse;
  const MyEditProfileLoaded({required this.editProfileRequestResponse});
  @override
  List<Object> get props => [editProfileRequestResponse];
}

// class MyEditProfileError extends MyProfileState {
//   final EditProfileRequestResponse editProfileRequestResponse;
//   const MyEditProfileError({required this.editProfileRequestResponse});
//   @override
//   List<Object> get props => [editProfileRequestResponse];
// }

class MyEditProfileErrorState extends MyProfileState {
  final String errorMsg;
  const MyEditProfileErrorState({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}