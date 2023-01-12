import 'package:all_in_one/models/UserModel.dart';
import 'package:all_in_one/services/AuthenticationRepository.dart';
import 'package:all_in_one/utils/AppStrings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository _authenticationRepository;
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthInitial()) {
    on<AuthStarted>(_onAuthStarted);
    on<AuthUserFound>(_onAuthUserFound);
    on<AuthUserNotFound>(_onAuthUserNotFound);
    on<LogoutUser>(_onLogoutUser);
  }

  _onAuthStarted(AuthStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      Stream<supabase.AuthState?> authState =
          _authenticationRepository.userStream;

      authState.first.then((supabase.AuthState? data) {
        final supabase.Session? session = data?.session;

        if (session == null) {
          add(AuthUserNotFound());
        } else {
          add(AuthUserFound(user: session.user));
        }
      });
    } catch (error) {
      emit(
        const AuthFailure(
          errorMessage: AppStrings.kSomethingWentWrong,
        ),
      );
    }
  }

  _onAuthUserFound(AuthUserFound event, Emitter<AuthState> emit) async {
    try {
      UserModel? userModel =
          await _authenticationRepository.getUserByID(userID: event.user.id);

      if (userModel != null) {
        emit(AuthSuccess(userModel: userModel));
      } else {
        _authenticationRepository.signOut();

        emit(
          const AuthFailure(
            errorMessage: AppStrings.kSomethingWentWrong,
          ),
        );
      }
    } catch (error) {
      emit(
        const AuthFailure(
          errorMessage: AppStrings.kSomethingWentWrong,
        ),
      );
    }
  }

  _onAuthUserNotFound(AuthUserNotFound event, Emitter<AuthState> emit) {
    emit(AuthUnauthenticated());
  }

  _onLogoutUser(LogoutUser event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // LOGIN USER
      await _authenticationRepository.signOut();

      emit(AuthUnauthenticated());
    } on supabase.AuthException catch (e) {
      emit(
        AuthFailure(
          errorMessage: e.message.toString(),
        ),
      );
    } catch (error) {
      emit(
        const AuthFailure(
          errorMessage: AppStrings.kSomethingWentWrong,
        ),
      );
    }
  }
}
