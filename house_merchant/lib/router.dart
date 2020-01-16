import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:house_merchant/screen/main/notification_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_create_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_detail_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_user_list_screen.dart';
import 'package:house_merchant/screen/store/store_edit_description_screen.dart';
import 'package:house_merchant/screen/store/store_edit_image_screen.dart';
import 'package:house_merchant/screen/store/store_edit_time_screen.dart';

class Router {
  static const HOME_PAGE = 'app://';

  static const BOOTSTRAP_PAGE = "app://BootStrapPage";
  static const ROUTER_PAGE = "app://RouterPage";

  static const PROMOTION_CREATE = "app://PromotionCreatePage";
  static const PROMOTION_DETAIL_PAGE = "app://PromotionDetailPage";

  static const NOTIFICATION_PAGE = "app://NotificationPage";
  static const PROMOTION_USER_LIST_PAGE = "app://PromotionUserListPage";

  static const SHOP_IMAGES_PAGE = "app://ShopImages";
  static const SHOP_DESCRIPTION_PAGE = "app://ShopDescription";
  static const SHOP_TIME_PAGE = "app://ShopTime";

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case PROMOTION_CREATE:
        return PromotionCreateScreen();

      case NOTIFICATION_PAGE:
        return NotificationScreen();

      case PROMOTION_DETAIL_PAGE:
        return PromotionDetailScreen();

      case PROMOTION_USER_LIST_PAGE:
        return PromotionUserListScreen();

      case SHOP_IMAGES_PAGE:
        return StoreEditImageScreen(
          params: params,
        );

      case SHOP_DESCRIPTION_PAGE:
        return StoreEditDescriptionScreen(
          params: params,
        );

      case SHOP_TIME_PAGE:
        return StoreEditTimeScreen(
          params: params,
        );
    }

    return null;
  }

  Router.replaceNoParams(BuildContext context, String url) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url)));
  }

  Router.replace(BuildContext context, String url, dynamic params) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, params);
            },
            settings: RouteSettings(name: url)));
  }

  Router.pushNoParams(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url)));
  }

  Router.push(BuildContext context, String url, dynamic params) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, params);
            },
            settings: RouteSettings(name: url)));
  }

  Router.pushDialogNoParams(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url),
            fullscreenDialog: true));
  }

  Router.pushDialog(BuildContext context, String url, dynamic params) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, params);
            },
            settings: RouteSettings(name: url),
            fullscreenDialog: true));
  }
}
