import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:meta/meta.dart';
part 'facebook_signin_state.dart';

class FacebookSignInCubit extends Cubit<FacebookSigninState> {
  FacebookSignInCubit() : super(FacebookSignInInitial());

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginWithFacebook() async {
    emit(FacebookSignInLoading());
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken!.token);

        // Once signed in, return the UserCredential
        final UserCredential userCredential = await _firebaseAuth.signInWithCredential(facebookAuthCredential);
        emit(FacebookSignInSuccess(user: userCredential.user!));
        print('Login successful. Firebase UID: ${userCredential.user!.uid}');
      }
      if(result.status == LoginStatus.cancelled) {
        emit(FacebookSignInDenied());
      }
      if(result.status == LoginStatus.failed) {
        emit(FacebookSignInError());
      }
    }catch(e) {
      print('Facebook sign-in failed: $e');
    }
  }



}
