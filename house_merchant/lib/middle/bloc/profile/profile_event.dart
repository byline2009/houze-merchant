import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);
}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent() : super();

  @override
  String toString() => 'GetProfileEvent {}';
}
