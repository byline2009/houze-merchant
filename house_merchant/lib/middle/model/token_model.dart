import 'package:equatable/equatable.dart';

class TokenModel extends Equatable {
  final String refresh;
  final String access;

  TokenModel({
    this.refresh,
    this.access,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => new TokenModel(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}
