// Enum to represent different states of Apple Sign In process
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AppleSignInStatus { initial, loading, success, failure }

// Cubit to manage the state of Apple Sign In process
class AppleSignInCubit extends Cubit<AppleSignInStatus> {
  AppleSignInCubit() : super(AppleSignInStatus.initial);





  // Future<void> signInWithApple() async {
  //   final AuthorizationResult result = await AppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
  //   ]);
  //
  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final AppleIdCredential appleIdCredential = result.credential;
  //
  //
  //
  //       await _firebaseAuth.signInWithCredential(credential);
  //       return _firebaseAuth.currentUser();
  //
  //       break;
  //
  //     case AuthorizationStatus.notDetermined:
  //       print('Sign in failed: ${result.error.localizedDescription}');
  //       break;
  //
  //     case AuthorizationStatus.denied:
  //       print('User cancelled');
  //       break;
  //   }
  //
  //   return null;
  // }

  Future<void> signInWithApple() async {
    try {
      // Change state to loading
      emit(AppleSignInStatus.loading);

      // if(AuthorizationStatus.authorized) {
      //   final AppleIdCredential appleIdCredential = result.credential;
      // }



      OAuthProvider oAuthProvider =
      OAuthProvider("apple.com");


      // Perform Apple Sign In
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        // nonce: Platform.isIOS ? nonce : null,
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'com.crayotech.letsCollect',
          redirectUri: Uri.parse(
              'https://lets-collect-cab16.firebaseapp.com/__/auth/handler'), // your redirect uri
        ),
      );

      // Use the credential to sign in or create an account
      print("AppleID: ${credential.email}");
      print("Name: ${credential.givenName}");
      print("UniqueID: ${credential.identityToken}");
      print("UserIdentifier: ${credential.userIdentifier}");
      print("State: ${credential.state}");
      print("Familyname: ${credential.familyName}");





      // Change state to success
      emit(AppleSignInStatus.success);
    } catch (e) {
      // Change state to failure in case of an error
      emit(AppleSignInStatus.failure);
    }
  }
}