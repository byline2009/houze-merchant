import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstant {

  static const int limitDefault = 10;

  static String 
    baseMerchantUrl, baseMerchantUrlRefreshToken, baseMerchantUrlLogin,
    baseMerchantUrlShop,
    baseMerchantUrlCoupon;

  static init() {

    final dotenv = DotEnv();

    APIConstant.baseMerchantUrl = dotenv.env['API_MERCHANT'];

    APIConstant.baseMerchantUrlLogin = baseMerchantUrl + "/oauth/api-token-auth/";
    APIConstant.baseMerchantUrlRefreshToken = baseMerchantUrl + "/oauth/api-token-refresh/";
    APIConstant.baseMerchantUrlCoupon = baseMerchantUrl + "/coupon/";
    APIConstant.baseMerchantUrlShop = baseMerchantUrl + "/shop/";
    
  }
}