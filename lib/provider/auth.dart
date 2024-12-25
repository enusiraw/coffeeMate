import 'package:firebase_auth/firebase_auth.dart';

class AuthState {
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  AuthState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isLoading,
    User? user,
    String? errorMessage,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
