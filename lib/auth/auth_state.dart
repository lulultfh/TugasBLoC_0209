import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}
class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}

class AuthAuthenticated extends AuthState {
  final String email;
  AuthAuthenticated({required this.email});

  @override
  List<Object?> get props => [email];
}
class AuthRegistered extends AuthState{}
class AuthUnauthenticated extends AuthState{}

