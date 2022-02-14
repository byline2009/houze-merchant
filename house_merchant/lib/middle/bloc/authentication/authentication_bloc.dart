import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_state.dart';
import 'package:house_merchant/middle/repository/user_repository.dart';
import 'package:house_merchant/utils/sqflite.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository = new UserRepository();

  AuthenticationBloc(AuthenticationState initialState) : super(initialState) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      OauthAPI.token = null;
      await userRepository.deleteToken();
      await Sqflite.flush();
      emit(AuthenticationUnauthenticated());
    });
  }
}
