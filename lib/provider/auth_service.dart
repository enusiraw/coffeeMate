import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yenebuna/provider/auth.dart';
import 'package:yenebuna/services/auth_service.dart';


// AuthService that interacts with FirebaseAuthService
class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuthService _authService;

  AuthNotifier(this._authService) : super(AuthState(isLoading: false));

  // Method to handle login
  Future<void> loginWithEmail(String email, String password) async {
    try {
      state = state.copyWith(isLoading: true);
      User? user = await _authService.loginWithEmailName(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

 // Send email verification
  Future<void> sendEmailVerification() async {
    try {
      await _authService.sendEmailVerification();
      state = state.copyWith(errorMessage: 'Verification email sent.');
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  // Method to handle sign-up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    try {
      state = state.copyWith(isLoading: true);
      User? user = await _authService.signUpWithEmail(
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        name: name,
      );
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  // Method to handle sign-out
  Future<void> signOut() async {
    await _authService.signOut();
    state = state.copyWith(user: null);
  }

  // Check if user is logged in
  Future<void> checkUserStatus() async {
    try {
      User? user = await _authService.getCurrentUser();
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

// AuthProvider using StateNotifierProvider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = FirebaseAuthService();
  return AuthNotifier(authService);
});
