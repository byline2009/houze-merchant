import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/bloc/overlay/index.dart';
import 'package:house_merchant/middle/model/shop_model.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';
import 'package:house_merchant/utils/sqflite.dart';

class OverlayBloc extends Bloc<OverlayBlocEvent, OverlayBlocState> {

  ShopRepository shopRepository = new ShopRepository();
  ShopModel currentShop;

  OverlayBloc();

  OverlayBlocState get initialState => ShopInitial();

  @override
  Stream<OverlayBlocState> mapEventToState(OverlayBlocEvent event) async* {

    if (event is ShopPicked) {
      yield ShopLoading();
      yield ShopChanged();
      try {
        final result = await shopRepository.getShops();
        final shop = await Sqflite.updateCurrentShop(shops: result);
        currentShop = await Sqflite.getCurrentShop();
        yield ShopSuccessful(result: result, shop: shop);
      } catch (error) {
        yield ShopFailure(error: error.toString());
      }
    }

  }
}