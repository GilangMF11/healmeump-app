
import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  final String role;

  const AuthLoginEvent({
    required this.username,
    required this.password,
    required this.role,
  });

  @override
  List<Object> get props => [
    username,
    password,
    role,
  ];
}
