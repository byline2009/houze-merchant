import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/login/index.dart';
import 'package:house_merchant/middle/repository/user_repository.dart';
import 'package:meta/meta.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository? userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc(
      {required this.authenticationBloc, required LoginState initialState})
      : super(initialState) {
    this.userRepository = authenticationBloc.userRepository;
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final token = await userRepository!.authenticate(
          phoneDial: event.phoneDial,
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(token: token));

        emit(LoginSuccessful());
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}
