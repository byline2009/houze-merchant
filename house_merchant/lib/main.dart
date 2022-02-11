import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/config/app_config.dart';
import 'package:house_merchant/constant/theme_constant.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_state.dart';
import 'package:house_merchant/screen/base/bootstrap_widget.dart';
import 'package:worker_manager/worker_manager.dart';

void main() async {
  // add this, and it should be the first line in main method
  ErrorWidget.builder = (errorDetails) {
    return Container(
      color: Colors.white,
      child: Text('Thông tin bị lỗi, vui lòng thử lại sau!'),
    );
  };
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: ThemeConstant.appbar_background_color,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  //App init
  await AppConfig.init();

  await Executor().warmUp();
  //Upgrade flutter to 2.10.1
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    BlocProvider(
      create: (BuildContext context) =>
          AuthenticationBloc(AuthenticationInitial())..add(AppStarted()),
      child: BootstrapScreen(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
