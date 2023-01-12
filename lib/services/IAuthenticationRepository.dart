import 'package:all_in_one/models/UserModel.dart';

abstract class IAuthenticationRepository {
  Future<UserModel?> registerUserWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel?> loginUserWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel?> getUserByID({required String userID});

  Future<void> signOut();
}
