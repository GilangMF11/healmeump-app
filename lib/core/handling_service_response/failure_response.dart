import 'package:equatable/equatable.dart';

class FailureResponse extends Equatable {
  const FailureResponse({
    required this.statusCode,
    required this.message,
  });
  final String message;
  final int statusCode;

  @override
  List<Object?> get props => [statusCode, message];
}
