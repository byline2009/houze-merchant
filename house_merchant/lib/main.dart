import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/config/app_config.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_bloc.dart';
import 'package:house_merchant/middle/bloc/authentication/authentication_event.dart';
import 'package:house_merchant/screen/base/bootstrap_widget.dart';

void main() async {

  // add this, and it should be the first line in main method
  WidgetsFlutterBinding.ensureInitialized(); 
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  //App init
  await AppConfig.init('.env.prod');

  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthenticationBloc()..add(AppStarted()),
      child: BootstrapScreen(),
    ),
  );
}
