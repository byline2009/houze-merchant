import 'package:flutter_dotenv/flutter_dotenv.dart';

class APIConstant {

  static const int limitDefault = 10;

  static String baseMerchantUrl, baseMerchantUrlRefreshToken,
    baseMerchantUrlCoupon;

  static init() {

    final dotenv = DotEnv();

    APIConstant.baseMerchantUrl = dotenv.env['API_MERCHANT'];
    APIConstant.baseMerchantUrlRefreshToken = baseMerchantUrl + "/oauth/api-token-refresh/";
    APIConstant.baseMerchantUrlCoupon = baseMerchantUrl + "/coupon/";
    
  }
}