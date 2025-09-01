import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lyrics_nigeria_flutter/helpers/route_helper.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  signInWithGoogle() async {
    final googleSignIn = GoogleSignIn.instance;

    // Authenticate user with desired scopes
    final GoogleSignInAccount? googleUser =
        await googleSignIn.authenticate(scopeHint: ['email']);

    if (googleUser == null) return; // user cancelled

    final googleAuth = await googleUser.authentication;

    // Only idToken is needed for Firebase Auth
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    doLogIn();
  }

  Future signInWithApple() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName
      ],
    );

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    doLogIn();

    final user = userCredential.user;

    // Fix display name if missing
    if (user?.displayName == null || user!.displayName!.isEmpty) {
      final fixDisplayNameFromApple = [
        appleCredential.givenName ?? '',
        appleCredential.familyName ?? '',
      ].join(' ').trim();

      await user?.updateDisplayName(fixDisplayNameFromApple);
    }

    // Fix email if missing (requires reauthentication)
    if (user?.email == null || user!.email!.isEmpty) {
      final credential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
      );

      await user!.reauthenticateWithCredential(credential);

      // Firebase requires verification
      await user.verifyBeforeUpdateEmail(appleCredential.email ?? '');
    }
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    doSignOut();
  }
}

doLogIn() {
  Get.offAndToNamed(RouteHelper.getLoadingPage());
}

doSignOut() {
  Get.offAndToNamed(RouteHelper.getLoadingPage());
}
