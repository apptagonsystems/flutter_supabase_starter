import 'package:all_in_one/models/UserModel.dart';
import 'package:all_in_one/services/AuthenticationRepository.dart';
import 'package:all_in_one/utils/AppStrings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) {
      on<RegisterUser>(_registerUser);
      on<LoginUser>(_loginUser);
    });
  }

  _registerUser(RegisterUser event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    try {
      // REGISTER USER
      UserModel? userModel =
          await _authenticationRepository.registerUserWithEmail(
        email: event.email,
        password: event.password,
      );

      if (userModel != null) {
        emit(AuthenticationSuccess(userModel: userModel));
      } else {
        emit(
          const AuthenticationFailure(
            errorMessage: AppStrings.kSomethingWentWrong,
          ),
        );
      }
    } on PostgrestException catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.message.toString()),
      );
    } on AuthException catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.message.toString()),
      );
    } catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.toString()),
      );
    }
  }

  _loginUser(LoginUser event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    try {
      // LOGIN USER
      UserModel? userModel = await _authenticationRepository.loginUserWithEmail(
        email: event.email,
        password: event.password,
      );

      if (userModel != null) {
        emit(AuthenticationSuccess(userModel: userModel));
      } else {
        emit(
          const AuthenticationFailure(
            errorMessage: AppStrings.kSomethingWentWrong,
          ),
        );
      }
    } on PostgrestException catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.message.toString()),
      );
    } on AuthException catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.message.toString()),
      );
    } catch (error) {
      emit(
        AuthenticationFailure(errorMessage: error.toString()),
      );
    }
  }
}
