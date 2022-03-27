import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jhentai/src/l18n/locale_text.dart';
import 'package:jhentai/src/network/eh_request.dart';
import 'package:jhentai/src/routes/getx_router_observer.dart';
import 'package:jhentai/src/routes/routes.dart';
import 'package:jhentai/src/service/download_service.dart';
import 'package:jhentai/src/service/storage_service.dart';
import 'package:jhentai/src/service/tag_translation_service.dart';
import 'package:jhentai/src/setting/advanced_setting.dart';
import 'package:jhentai/src/setting/favorite_setting.dart';
import 'package:jhentai/src/setting/gallery_setting.dart';
import 'package:jhentai/src/setting/path_setting.dart';
import 'package:jhentai/src/setting/site_setting.dart';
import 'package:jhentai/src/setting/tab_bar_setting.dart';
import 'package:jhentai/src/setting/user_setting.dart';
import 'package:jhentai/src/utils/log.dart';

import 'config/theme_config.dart';

void main() async {
  await beforeInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'JHenTai',
      theme: ThemeConfig.light,
      locale: window.locale,
      fallbackLocale: const Locale('en', 'US'),
      translations: LocaleText(),
      getPages: Routes.getPages(),
      initialRoute: Routes.home,
      navigatorObservers: [GetXRouterObserver()],

      /// enable swipe back feature
      popGesture: true,
      onInit: onInit,
    );
  }
}

Future<void> beforeInit() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PathSetting.init();

  await GetStorage.init();
  StorageService.init();

  AdvancedSetting.init();
  await Log.init();
  UserSetting.init();
  TagTranslationService.init();
  GallerySetting.init();
  TabBarSetting.init();

  SiteSetting.init();

  await EHRequest.init();
  await DownloadService.init();

  TagTranslationService.init();
}

Future<void> onInit() async {
  FavoriteSetting.init();
  SiteSetting.refresh();
}