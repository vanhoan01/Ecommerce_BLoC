part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoadAuth extends AuthEvent {
  @override
  List<Object> get props => [];
}

class Signin extends AuthEvent {
  final String email;
  final String password;

  const Signin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
