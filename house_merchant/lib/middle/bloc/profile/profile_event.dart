import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {
  GetProfileEvent();

  @override
  String toString() => 'GetProfileEvent {}';
}
