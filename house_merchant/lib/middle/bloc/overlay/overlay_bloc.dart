import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/bloc/overlay/index.dart';

class OverlayBloc extends Bloc<OverlayEvent, OverlayState> {


  OverlayBloc();

  OverlayState get initialState => ShopInitial();

  @override
  Stream<OverlayState> mapEventToState(OverlayEvent event) async* {

    if (event is ShopPicked) {
    }

  }
}