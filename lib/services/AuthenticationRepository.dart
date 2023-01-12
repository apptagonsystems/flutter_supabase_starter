import 'package:all_in_one/models/UserModel.dart';
import 'package:all_in_one/services/IAuthenticationRepository.dart';
import 'package:all_in_one/utils/AppConstants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationRepository extends IAuthenticationRepository {
  final supabase = Supabase.instance.client;

  Stream<AuthState?> get userStream => supabase.auth.onAuthStateChange;

  @override
  Future<UserModel?> registerUserWithEmail(
      {required String email, required String password}) async {
    try {
      final AuthResponse authResponse =
          await supabase.auth.signUp(email: email, password: password);
      final Session? session = authResponse.session;
      final User? user = authResponse.user;

      if (session != null && user != null) {
        // store info in database
        var response = await supabase.from('users').insert({
          'email': email,
          'authType': AppConstants.userAuthTypeEMAIL,
        });

        UserModel? userModel = await getUserByID(userID: authResponse.user!.id);
        return userModel;
      } else {
        // show error message
        return null;
      }
    } on PostgrestException catch (error) {
      print('${error.message}');
      rethrow;
    } on AuthException catch (error) {
      print('${error.message}');
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserByID({required String userID}) async {
    try {
      final response =
          await supabase.from('users').select().eq('id', userID).single();
      if (response != null) {
        final userModel = UserModel.fromJson(response as Map<String, dynamic>);
        return userModel;
      } else {
        return null;
      }
    } on PostgrestException catch (error) {
      print('${error.message}');
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> loginUserWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse authResponse = await supabase.auth
          .signInWithPassword(email: email, password: password);
      final Session? session = authResponse.session;
      final User? user = authResponse.user;

      if (session != null && user != null) {
        UserModel? userModel = await getUserByID(userID: authResponse.user!.id);
        return userModel;
      } else {
        // show error message
        return null;
      }
    } on PostgrestException catch (error) {
      print('${error.message}');
      rethrow;
    } on AuthException catch (error) {
      print('${error.message}');
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
