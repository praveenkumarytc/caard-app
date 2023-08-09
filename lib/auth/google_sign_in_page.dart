import 'package:cardapp/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/images.dart';
import 'animated_shape/animated_shape.dart';
import 'animated_shape/google_bloc.dart';
import 'auth cubit/auth_cubit.dart';

class GoogleSignInPage extends StatefulWidget {
  @override
  _GoogleSignInPageState createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  final googleSignInCubit = GoogleSignInCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const AnimatedShape(
                  color: primaryColor,
                  show: true,
                  title: "Welcome to ",
                  subTitle: 'Ad Caard',
                ),
                const SizedBox(height: 24),
                Image.asset(
                  Images.appLogo,
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 300,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Sign in with your Google account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton.icon(
                    onPressed: () async {
                      context.read<AuthenticationCubit>().signInWithGoogle();
                      // CollectionReference userCategoriesRef = FirebaseFirestore.instance.collection('user_categories');

                      // // Define the data for the user categories
                      // List<Map<String, dynamic>> userCategoriesData = [
                      //   {
                      //     "designation": "Doctor",
                      //     "id": 1
                      //   },
                      //   {
                      //     "designation": "Advocate",
                      //     "id": 2
                      //   },
                      //   {
                      //     "designation": "Influencer",
                      //     "id": 3
                      //   }
                      // ];

                      // // Add each user category to the Firestore collection
                      // userCategoriesData.forEach((categoryData) {
                      //   userCategoriesRef.add(categoryData).then((docRef) => print("Document added with ID: ${docRef.id}")).catchError((error) => print("Error adding document: $error"));
                      // });
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Sign In with Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
