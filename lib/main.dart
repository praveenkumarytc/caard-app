// ignore_for_file: library_private_types_in_public_api

import 'package:cardapp/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'auth/auth cubit/auth_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox(hiveBox);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(create: (context) => AuthenticationCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashPage(),
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: "YsabeauOffice",
          primaryColor: primaryColor,
        ),
        darkTheme: ThemeData(
          fontFamily: "YsabeauOffice",
          primaryColor: primaryColor,
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
      ),
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();
const primaryColor = Color.fromRGBO(44, 15, 54, 1);
const primaryColor2 = Color.fromRGBO(36, 15, 43, 1);
const hiveBox = "userInfoBox";
