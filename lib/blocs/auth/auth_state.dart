part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoaded extends AuthState {
  final String? email;
  final String? password;
  final bool? remember;
  final List<String?> errors = [];

  AuthLoaded({this.email, this.password, this.remember = false});

  @override
  List<Object?> get props => [email, password, remember, errors];
}

class AuthError extends AuthState {
  @override
  List<Object> get props => [];
}
