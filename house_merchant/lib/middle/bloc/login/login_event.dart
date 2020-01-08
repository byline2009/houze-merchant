import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {

  final String phoneDial;
  final String username;
  final String password;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    this.phoneDial,
  }) : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed { phone_dial: $phoneDial, username: $username, password: $password }';
}