import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
part 'facebook_signin_state.dart';

class FacebookSignInCubit extends Cubit<FacebookSigninState> {
  FacebookSignInCubit() : super(FacebookSignInInitial());


  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> _getFacebookUserData(String accessToken) async {
    final String graphEndpoint = "https://graph.facebook.com/v14.0/me?fields=name,email";
    final Map<String, String> queryParams = {"access_token": accessToken};
    final Uri url = Uri.parse(graphEndpoint).replace(queryParameters: queryParams);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String userName = data["name"];
      final String userEmail = data["email"];

      print("User Name: $userName");
      print("User Email: $userEmail");
    } else {
      print("Error fetching user data: ${response.statusCode}");
    }
  }

  Future<UserCredential?> loginWithFacebook() async {
    // checkUserSignInStatus();
    emit(FacebookSignInLoading());

      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        // Create a credential from the access token
        final  accessToken = result.accessToken!.token;

        final credential = FacebookAuthProvider.credential(accessToken);

        try {
          final UserCredential userCredential = await auth.signInWithCredential(credential);
          final user = userCredential.user;
          print("Signed in as ${user?.displayName}");

          // Access Graph API with retrieved access token
          await _getFacebookUserData(accessToken);
        } on FirebaseAuthException catch (e) {
          emit(FacebookSignInError());
          // Handle Firebase Authentication errors
          print(e.code);
          print(e.message);
        } catch (e) {
          print(e.toString());
          emit(FacebookSignInError());
        }
      }


      if (result.status == LoginStatus.cancelled) {
        emit(FacebookSignInDenied());
      }
      if (result.status == LoginStatus.failed) {
        emit(FacebookSignInError());
      }
      return null;
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
