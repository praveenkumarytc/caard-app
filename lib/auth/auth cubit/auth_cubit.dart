// ignore_for_file: use_build_context_synchronously

import 'package:cardapp/auth/login_page.dart';
import 'package:cardapp/dashboard/home.dart';
import 'package:cardapp/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../animated_shape/loading_error.dart';
import 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthenticationCubit() : super(AuthenticationInitial());
  BuildContext context = navigatorKey.currentContext!;
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthenticationLoading());

      LoadingSheet.show(context);

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final bool isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;

        if (isNewUser) {
          emit(AuthenticationSuccess(user.uid));
          Navigator.pushAndRemoveUntil(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => false);
        } else {
          emit(AuthenticationSuccess(user.uid));
          Navigator.pushAndRemoveUntil(
              navigatorKey.currentContext!,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
              (route) => false);
        }
      } else {
        emit(AuthenticationFailure('Failed to sign in with Google'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(e.code));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthenticationLoading());
      LoadingSheet.show(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SplashPage(),
          ),
          (route) => false);
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();

      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthenticationFailure(e.toString()));
    }
  }
}
