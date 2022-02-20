import 'package:flutter/material.dart';
import 'package:house_merchant/screen/login/login_screen.dart';
import 'package:house_merchant/screen/main/notification_screen.dart';
import 'package:house_merchant/screen/main/store_screen.dart';
import 'package:house_merchant/screen/profile/change_password_screen.dart';
import 'package:house_merchant/screen/profile/contact_screen.dart';
import 'package:house_merchant/screen/profile/profile_screen.dart';
import 'package:house_merchant/screen/promotion/coupon_detail_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_create_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_edit_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_scan_success_screen.dart';
import 'package:house_merchant/screen/promotion/promotion_user_list_screen.dart';
import 'package:house_merchant/screen/store/store_edit_description_screen.dart';
import 'package:house_merchant/screen/store/store_edit_image_screen.dart';
import 'package:house_merchant/screen/store/store_edit_time_screen.dart';

import 'screen/base/sc_image_view.dart';

class AppRouter {
  static const HOME_PAGE = 'app://';

  static const BOOTSTRAP_PAGE = "app://BootStrapPage";
  static const ROUTER_PAGE = "app://RouterPage";

  static const COUPON_CREATE = "app://CouponCreatePage";
  static const COUPON_DETAIL_PAGE = "app://CouponDetailPage";
  static const COUPON_EDIT = "app://CouponEditPage";

  static const NOTIFICATION_PAGE = "app://NotificationPage";
  static const COUPON_USER_LIST_PAGE = "app://CouponUserListPage";
  static const COUPON_SCAN_QR_SUCCESS_PAGE = "app://CouponQRScanSuccessPage";

  static const SHOP_IMAGES_PAGE = "app://ShopImages";
  static const SHOP_DESCRIPTION_PAGE = "app://ShopDescription";
  static const SHOP_TIME_PAGE = "app://ShopTime";

  static const IMAGE_VIEW_SCREEN = "app://ImageViewPage";

  static const CONTACT_PAGE = "app://ContactPage";
  static const PROFILE_PAGE = "app://ProfilePage";
  static const CHANGE_PASSWORD = "app://ChangePassword";

  Widget _getPage(String url, dynamic params) {
    switch (url) {
      case IMAGE_VIEW_SCREEN:
        var args = params as ImageViewScreenArgument;
        return ImageViewScreen(params: args);

      case COUPON_CREATE:
        return CouponCreateScreen(params: params);

      case NOTIFICATION_PAGE:
        return NotificationScreen();

      case COUPON_DETAIL_PAGE:
        return CouponDetailScreen(params: params);

      case COUPON_EDIT:
        return CouponEditScreen(params: params);

      case COUPON_USER_LIST_PAGE:
        return CouponUserListScreen(params: params);

      case COUPON_SCAN_QR_SUCCESS_PAGE:
        return PromotionScanSuccessScreen(params: params);

      case SHOP_IMAGES_PAGE:
        return StoreEditImageScreen(params: params);

      case SHOP_DESCRIPTION_PAGE:
        final arg = params as StoreEditArgument;
        return StoreEditDescriptionScreen(params: arg);

      case SHOP_TIME_PAGE:
        return StoreEditTimeScreen(params: params);

      case CONTACT_PAGE:
        return ContactScreenWidget();

      case PROFILE_PAGE:
        return ProfileScreenWidget();

      case CHANGE_PASSWORD:
        return ChangePasswordScreen();
      default:
        return LoginScreen();
    }
  }

  AppRouter.replaceNoParams(BuildContext context, String url) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url)));
  }

  AppRouter.replace(BuildContext context, String url, dynamic params) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, params);
            },
            settings: RouteSettings(name: url)));
  }

  AppRouter.pushNoParams(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url)));
  }

  AppRouter.push(BuildContext context, String url, dynamic params) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, params);
            },
            settings: RouteSettings(name: url)));
  }

  AppRouter.pushDialogNoParams(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return _getPage(url, null);
            },
            settings: RouteSettings(name: url),
            fullscreenDialog: true));
  }

  AppRouter.pushDialog(BuildContext context, String url, dynamic params) {
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
