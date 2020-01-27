import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopRepository shopRepository = ShopRepository();

  ShopBloc();

  ShopState get initialState => ShopInitial();

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is ShopGetDetail) {
      try {
        final result = await shopRepository.getShop(event.id);
        yield ShopGetDetailSuccessful(result: result);
      } catch (error) {
        yield ShopFailure(error: error.toString());
      }
    }

    if (event is SaveButtonPressed) {
      try {
        yield ShopLoading();
        final result = await shopRepository.updateDescription(
          event.name,
          event.description);
        yield ShopSuccessful();
      } catch (error) {
        yield ShopFailure(error: error.toString());
      }
    }
  }
}
