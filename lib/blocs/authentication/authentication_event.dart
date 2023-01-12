part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class RegisterUser extends AuthenticationEvent {
  final String email;
  final String password;

  const RegisterUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() {
    return 'RegisterUser ';
  }
}

class LoginUser extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginUser({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];

  @override
  String toString() {
    return 'LoginUser ';
  }
}

class LogoutUser extends AuthenticationEvent {}
