import 'package:bloc/bloc.dart';
import 'package:house_merchant/middle/bloc/shop/index.dart';
import 'package:house_merchant/middle/repository/shop_repository.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopRepository shopRepository = ShopRepository();

  ShopBloc(ShopState initialState) : super(initialState) {
    on<ShopGetDetail>((event, emit) async {
      try {
        final result = await shopRepository.getShop(event.id);
        emit(ShopGetDetailSuccessful(result: result));
      } catch (error) {
        emit(ShopFailure(error: error.toString()));
      }
    });
    on<SaveButtonPressed>((event, emit) async {
      try {
        emit(ShopLoading());
        final result = await shopRepository.updateInfo(event.shopModel);
        print(result);
        emit(ShopSuccessful());
      } catch (error) {
        emit(ShopFailure(error: error.toString()));
      }
    });
  }

  // ShopState get initialState => ShopInitial();

  // @override
  // Stream<ShopState> mapEventToState(ShopEvent event) async* {
  //   if (event is ShopGetDetail) {
  //     try {
  //       final result = await shopRepository.getShop(event.id);
  //       yield ShopGetDetailSuccessful(result: result);
  //     } catch (error) {
  //       yield ShopFailure(error: error.toString());
  //     }
  //   }

  //   if (event is SaveButtonPressed) {
  //     try {
  //       yield ShopLoading();
  //       final result = await shopRepository.updateInfo(event.shopModel);
  //       print(result);
  //       yield ShopSuccessful();
  //     } catch (error) {
  //       yield ShopFailure(error: error.toString());
  //     }
  //   }
  // }
}
