import 'package:get/get.dart';
import 'package:jhentai/src/utils/log.dart';

import '../service/storage_service.dart';

class AdvancedSetting {
  static RxBool enableDomainFronting = false.obs;
  static RxBool enableLogging = true.obs;

  static void init() {
    Map<String, dynamic>? map = Get.find<StorageService>().read<Map<String, dynamic>>('advancedSetting');
    if (map != null) {
      _initFromMap(map);
      Log.info('init AdvancedSetting success', false);
    }
  }

  static saveEnableDomainFronting(bool enableDomainFronting) {
    AdvancedSetting.enableDomainFronting.value = enableDomainFronting;
    _save();
  }

  static saveEnableLogging(bool enableLogging) {
    AdvancedSetting.enableLogging.value = enableLogging;
    _save();
  }

  static Future<void> _save() async {
    await Get.find<StorageService>().write('advancedSetting', _toMap());
  }

  static void clear() {
    enableDomainFronting.value = false;
    Get.find<StorageService>().remove('advancedSetting');
  }

  static Map<String, dynamic> _toMap() {
    return {
      'enableDomainFronting': enableDomainFronting.value,
      'enableLogging': enableLogging.value,
    };
  }

  static _initFromMap(Map<String, dynamic> map) {
    enableDomainFronting.value = map['enableDomainFronting'];
    enableLogging.value = map['enableLogging'];
  }
}