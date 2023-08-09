import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInState(isLoading: false, isError: false));

  void signInWithGoogle() async {
    try {
      emit(state.copyWith(isLoading: true, isError: false));

      // Simulate an asynchronous sign-in process
      await Future.delayed(Duration(seconds: 2));

      // Perform sign-in logic here

      emit(state.copyWith(isLoading: false, isError: false));
    } catch (error) {
      emit(state.copyWith(isLoading: false, isError: true));
    }
  }
}

class GoogleSignInState {
  final bool isLoading;
  final bool isError;

  GoogleSignInState({required this.isLoading, required this.isError});

  GoogleSignInState copyWith({bool? isLoading, bool? isError}) {
    return GoogleSignInState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleSignInCubit, GoogleSignInState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: state.isLoading
              ? null
              : () {
                  context.read<GoogleSignInCubit>().signInWithGoogle();
                },
          child: Text(
            'Sign In with Google',
            style: TextStyle(fontSize: 16),
          ),
        );
      },
    );
  }
}
