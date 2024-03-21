// Enum to represent different states of Apple Sign In process
import 'package:bloc/bloc.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

enum AppleSignInStatus { initial, loading, success, failure }

// Cubit to manage the state of Apple Sign In process
class AppleSignInCubit extends Cubit<AppleSignInStatus> {
  AppleSignInCubit() : super(AppleSignInStatus.initial);

  Future<void> signInWithApple() async {
    try {
      // Change state to loading
      emit(AppleSignInStatus.loading);

      // Perform Apple Sign In
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'your_client_id',
          redirectUri: Uri.parse(
              'https://example.com/callback'), // your redirect uri
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