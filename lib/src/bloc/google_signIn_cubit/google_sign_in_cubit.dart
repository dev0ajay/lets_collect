import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInInitial());
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;


  void login() async {
    emit(GoogleSignInCubitLoading());
    try {
      //select acoount
      final userAccount = await googleSignIn.signIn();



      //user dismissed the dialog box
      if(userAccount == null) return null;

      final GoogleSignInAuthentication googleSignInAuthentication = await userAccount.authentication;


      //Create OAuth credentials from auth object
      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
      );

      //Login to firebase using credentials
      final userCredentials = await _auth.signInWithCredential(credential);

      emit(GoogleSignInSuccess(user: userCredentials.user!));




    } catch(e) {
      print(e);
      emit(GoogleSignInError());
    }
  }

  void signOut() async{
    try {
      GoogleSignIn().signOut();
      googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      emit(GoogleSignInLoggedOut());

    } catch(e) {
      print(e);
    }
  }


// void signInSilently() async{
//   try {
//     // final userAccount = await googleSignIn.signIn();
//     if(userAccount != null) {
//
//     }
//     // emit(GoogleSignInLoggedOut());
//
//   } catch(e) {}
// }

}
