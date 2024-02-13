import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInInitial());
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;


  void login() async {
    emit(GoogleSignInLoading());
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
      emit(GoogleSignInError(error: e.toString()));
    }
  }

  void signOut() async{
    try {
      GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      emit(GoogleSignInLoggedOut());

    } catch(e) {}
  }


}
