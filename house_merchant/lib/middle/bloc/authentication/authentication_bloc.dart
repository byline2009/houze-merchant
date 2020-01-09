import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/api/oauth_api.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_state.dart';
import 'package:house_merchant/middle/repository/user_repository.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository = new UserRepository();

  AuthenticationBloc();

  @override
  AuthenticationState get initialState => new AuthenticationInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      OauthAPI.token = null;
      await userRepository.deleteToken();
      //await Sqflite.flush();
      yield AuthenticationUnauthenticated();
    }
  }
}