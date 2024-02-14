import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lyrics_nigeria_flutter/helpers/route_helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    doLogIn();
  }

  Future signInWithApple() async{
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
    );

    //Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken
    );
    final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential).then((value) => doLogIn());

    if (userCredential.user?.displayName == null ||
        (userCredential.user?.displayName != null && userCredential.user!.displayName!.isEmpty)) {
      final fixDisplayNameFromApple = [
        appleCredential.givenName ?? '',
        appleCredential.familyName ?? '',
      ].join(' ').trim();
      await userCredential.user?.updateDisplayName(fixDisplayNameFromApple);
    }
    if (userCredential.user?.email == null ||
        (userCredential.user?.email != null && userCredential.user!.email!.isEmpty)) {
      await userCredential.user?.updateEmail(appleCredential.email ?? '');
    }
    //Now, FirebaseAuth.instance.currentUser contains the user with all the name and email updated.
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    doSignOut();
  }
}

doLogIn(){
  Get.offAndToNamed(RouteHelper.getLoadingPage());
}

doSignOut(){
  Get.offAndToNamed(RouteHelper.getLoadingPage());
}
