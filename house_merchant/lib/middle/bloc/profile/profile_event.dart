import 'package:equatable/equatable.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();

  @override
  String toString() => 'GetProfileEvent {}';
}
