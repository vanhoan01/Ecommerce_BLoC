import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:ecommerce_bloc/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<LoadAuth>(_onLoadAuth);
    on<Signin>(_onSignin);
  }

  Future<void> _onSignin(Signin event, Emitter<AuthState> emit) async {
    if (state is AuthLoaded) {
      try {
        await _authRepository.logInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
      } catch (_) {}
    }
  }

  Future<void> _onLoadAuth(event, Emitter<AuthState> emit) async {
    emit(AuthInitial());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(AuthLoaded());
    } catch (e) {
      emit(AuthError());
    }
  }
}
