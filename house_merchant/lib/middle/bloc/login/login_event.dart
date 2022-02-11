import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String phoneDial;
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    this.phoneDial,
  });

  @override
  String toString() =>
      'LoginButtonPressed { phone_dial: $phoneDial, username: $username, password: $password }';
}
