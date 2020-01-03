import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:house_merchant/config/app_config.dart';
import 'package:house_merchant/screen/base/bootstrap_widget.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIOverlays([]);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //App init
  await AppConfig.init('.env.dev');

  // runApp(
  //   BlocProvider(
  //     create: (BuildContext context) => AuthenticationBloc()..add(AppStarted()),
  //     child: BootstrapScreen(),
  //   ),
  // );

  runApp(BootstrapScreen(),);
}
