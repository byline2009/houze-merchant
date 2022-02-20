import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_state.dart';
import 'package:house_merchant/middle/bloc/login/index.dart';
import 'package:house_merchant/middle/model/language_model.dart';
import 'package:house_merchant/screen/login/login_screen.dart';
import 'package:house_merchant/screen/main/main_screen.dart';
import 'package:house_merchant/utils/cupertino_localizations_vi.dart';
import 'package:house_merchant/utils/localizations_delegate_util.dart';

class BootstrapScreen extends StatefulWidget {
  BootstrapScreen({Key? key}) : super(key: key);

  @override
  _BootstrapScreenState createState() => _BootstrapScreenState();
}

class _BootstrapScreenState extends State<BootstrapScreen> {
  // Default Language
  var locale = Locale('vi', 'VN');

  @override
  Widget build(BuildContext context) {
    final _loginBloc = LoginBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        initialState: LoginInitial());

    //Get default language
    final getLanguage = LanguageModel(
      flag: 'vi',
      locale: 'vi',
      name: 'Tiếng Việt',
    );
    locale = Locale(getLanguage.locale!, getLanguage.locale!.toUpperCase());

    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (BuildContext context) => _loginBloc,
          ),
        ],
        child: MaterialApp(
            builder: (context, child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                  data: data.copyWith(
                    textScaleFactor: 1.0,
                  ),
                  child: child!);
            },
            showPerformanceOverlay: false,
            localizationsDelegates: [
              LocalizationsDelegateUtil(),
              CupertinoLocalizationsVi.delegate,
              DefaultCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            theme: ThemeData(
              primarySwatch: Colors.blue,
              bottomAppBarColor: ThemeConstant.primary_color,
              primaryColorBrightness: Brightness.light,
            ),
            locale: locale,
            supportedLocales: [
              const Locale('en', 'EN'),
              const Locale('vi', 'VI'),
            ],
            debugShowCheckedModeBanner: false,
            home: BlocBuilder(
                bloc: _loginBloc.authenticationBloc,
                builder:
                    (BuildContext context, AuthenticationState currentState) {
                  print("Status: $currentState");

                  if (currentState is AuthenticationLoading ||
                      currentState is AuthenticationInitial) {
                    return Scaffold(
                        backgroundColor: Colors.white,
                        body: Center(
                          child: CupertinoActivityIndicator(),
                        ));
                  }

                  // If Authenticated, go to main screen
                  if (currentState is AuthenticationAuthenticated) {
                    //Add handler listening notification hub
                    return MainScreen();
                  }

                  return LoginScreen();
                })));
  }
}
