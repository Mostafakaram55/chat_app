import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_size.dart';

class AppConstants {
  static String accessToken = '';
  static String refreshToken = '';
  static const String pathForImages = 'assets/images/';
  static const String pathForSvg = 'assets/svg/';
  static const String onboardingKey = 'onboarding';
  static const String appRole = 'appRole';
  static const String userModelShared = 'userModelShared';
  static const String favoriteProductId = 'favoriteProductId';
  static const String cardProductId = "cardProductId";
  static const String deepLinkAppId = '691ec5a59e06ac8d04590b9a';
  static const String appVersionBundleId = 'com.mdsoft.korlen';
  static const String countryCode = '+964';

  static TextEditingController searchController = TextEditingController();
  static TextEditingController changePassword = TextEditingController();
  static TextEditingController charge = TextEditingController();

  static final OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.size32),
    borderSide: BorderSide(width: AppSize.borderSize, color: AppColors.greyE7),
  );

  static final OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.size32),
    borderSide: BorderSide(width: AppSize.borderSize, color: AppColors.greyE7),
  );
  static final OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.size32),
    borderSide: BorderSide(width: AppSize.borderSize, color: AppColors.red),
  );
  static final OutlineInputBorder removeBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppSize.size32),
    borderSide: BorderSide.none,
  );

  static const SystemUiOverlayStyle systemUiOverlayStyleLight =
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: AppColors.transparent,
      );
  static const SystemUiOverlayStyle systemUiOverlayStyleDark =
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      );

  static final List<BoxShadow> boxShadowForImage = [
    BoxShadow(
      spreadRadius: -2,
      color: Color(0xff101828).withAlpha(08),
      blurRadius: 6,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      spreadRadius: -4,
      color: Color(0xff101828).withAlpha(14),
      blurRadius: 16,
      offset: Offset(0, 12),
    ),
  ];
}
