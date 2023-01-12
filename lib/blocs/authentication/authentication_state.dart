part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final UserModel userModel;

  const AuthenticationSuccess({required this.userModel});

  @override
  List<Object?> get props => [userModel];
}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;
  const AuthenticationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class Unauthenticated extends AuthenticationState {}
