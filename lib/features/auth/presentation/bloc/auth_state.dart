
import 'package:equatable/equatable.dart';
import 'package:healmeumpapp/features/auth/domain/entities/login_entities.dart';

class AuthState extends Equatable {
  // Loading
  final bool? loadingLogin;
  // Status
  final String? statusLogin;
  // Message
  final String? messageLogin;
  // Data
  final LoginEntities? dataLogin;

  const AuthState({
    this.loadingLogin = false,
    this.statusLogin,
    this.messageLogin,
    this.dataLogin,
  });

  AuthState copyWith({
    bool? loadingLogin,
    String? statusLogin,
    String? messageLogin,
    LoginEntities? dataLogin,
  }) => AuthState(
    loadingLogin: loadingLogin ?? this.loadingLogin,
    statusLogin: statusLogin ?? this.statusLogin,
    messageLogin: messageLogin ?? this.messageLogin,
    dataLogin: dataLogin ?? this.dataLogin,
  );
  
  @override
  List<Object?> get props => [loadingLogin, statusLogin, messageLogin, dataLogin];
}

