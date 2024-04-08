import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

part 'facebook_signin_state.dart';

class FacebookSignInCubit extends Cubit<FacebookSigninState> {
  FacebookSignInCubit() : super(FacebookSignInInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithFacebook() async {
    // checkUserSignInStatus();
    emit(FacebookSignInLoading());
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();
      final AccessToken? accessToken = await FacebookAuth.instance.accessToken;

      if (result.status == LoginStatus.success) {
        // Create a credential from the access token

        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        // Once signed in, return the UserCredential
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(facebookAuthCredential);

        emit(FacebookSignInSuccess(user: userCredential.user!));
        print('Login successful. Firebase UID: ${userCredential.user!.uid}');
      }
      if (result.status == LoginStatus.cancelled) {
        emit(FacebookSignInDenied());
      }
      if (result.status == LoginStatus.failed) {
        emit(FacebookSignInError());
      }
    } catch (e) {
      if (kDebugMode) {
        print('Facebook sign-in failed: $e');
      }
      emit(FacebookSignInError());
    }
  }

  void checkUserSignInStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        // Attempt a silent sign-in to refresh the token
        await currentUser.reload();
      } catch (e) {
        // If silent sign-in fails, handle the error or re-authenticate the user
        print('Error during silent sign-in: $e');
      }
    }
  }

  // void refreshFacebookAccessToken() async {
  //   try {
  //     final LoginResult result = await FacebookAuth.instance.refreshAccessToken();
  //
  //     if (result.status == LoginStatus.success) {
  //       print('Access token refreshed successfully!');
  //       print('New access token: ${result.accessToken.token}');
  //     } else {
  //       print('Access token refresh failed.');
  //       print('Error: ${result.message}');
  //     }
  //   } catch (e) {
  //     print('Error while refreshing access token: $e');
  //   }
  // }

  Future<void> logOutFromFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
