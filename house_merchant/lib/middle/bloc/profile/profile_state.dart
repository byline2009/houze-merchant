import 'package:equatable/equatable.dart';
import 'package:house_merchant/middle/model/profile_model.dart';
import 'package:meta/meta.dart';

abstract class ProfileState extends Equatable {
  List<Object> get props => [];
}

class ProfileGetSuccessful extends ProfileState {
  final ProfileModel result;

  ProfileGetSuccessful({required this.result});
  @override
  String toString() => 'ShopGetDetailSuccessful { result: $result }';
}

class ProfileInitial extends ProfileState {
  @override
  String toString() => 'ProfileInitial';
}

class ProfileLoading extends ProfileState {
  @override
  String toString() => 'ProfileLoading';
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({required this.error});

  @override
  String toString() => 'ProfileFailure { error: $error }';
}
