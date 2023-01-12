part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel userModel;

  const AuthSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthUser extends AuthState {
  final AuthState authState;

  const AuthUser({required this.authState});

  @override
  List<Object?> get props => [authState];
}

class AuthFailure extends AuthState {
  final String errorMessage;
  const AuthFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class AuthUnauthenticated extends AuthState {}
