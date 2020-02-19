import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstant {
  static const int limitDefault = 10;

  static String baseMerchantUrl,
      baseMerchantUrlRefreshToken,
      baseMerchantUrlLogin,
      baseMerchantUrlProfile,
      baseMerchantUrlChangepass,
      baseMerchantUrlShop,
      baseMerchantUrlShopImageCreate,
      baseMerchantUrlShopImageDelete,
      baseMerchantUrlCoupon,
      baseMerchantUrlCouponUpload;

  static init() {
    final dotenv = DotEnv();

    APIConstant.baseMerchantUrl = dotenv.env['API_MERCHANT'];

    APIConstant.baseMerchantUrlLogin =
        baseMerchantUrl + "/oauth/api-token-auth/";
    APIConstant.baseMerchantUrlProfile = baseMerchantUrl + "/oauth/profile/";
    APIConstant.baseMerchantUrlChangepass = baseMerchantUrl + "/oauth/change-password/";
    APIConstant.baseMerchantUrlRefreshToken =
        baseMerchantUrl + "/oauth/api-token-refresh/";
    APIConstant.baseMerchantUrlCoupon = baseMerchantUrl + "/coupon/";
    APIConstant.baseMerchantUrlCouponUpload =
        baseMerchantUrl + "/coupon/upload-image/";
    APIConstant.baseMerchantUrlShop = baseMerchantUrl + "/shop/";

    APIConstant.baseMerchantUrlShopImageCreate =
        baseMerchantUrl + "/shop/shop-image-create/";
    APIConstant.baseMerchantUrlShopImageDelete =
        baseMerchantUrl + "/shop/shop-image-delete/";
  }
}
