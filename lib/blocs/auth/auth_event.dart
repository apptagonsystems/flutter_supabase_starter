part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthUserFound extends AuthEvent {
  final supabase.User user;

  const AuthUserFound({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUserNotFound extends AuthEvent {}

class LogoutUser extends AuthEvent {}
