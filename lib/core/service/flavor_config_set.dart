
import 'package:healmeumpapp/global/constant/base_url.dart';

enum Flavor { dev, staging, production }

class FlavorConfigSet {
  static String getBaseUrl() {
    switch (Config.appFlavor) {
      case Flavor.dev:
        return BaseUrl.BASE_URL_DEV;
      case Flavor.staging:
        return BaseUrl.BASE_URL_STAGING;
      case Flavor.production:
        return BaseUrl.BASE_URL;
    }
  }
}

class Config {
  static late Flavor appFlavor;

  static void setAppFlavor(String flavor) {
    switch (flavor) {
      case 'dev':
        appFlavor = Flavor.dev;
        break;
      case 'staging':
        appFlavor = Flavor.staging;
        break;
      case 'production':
        appFlavor = Flavor.production;
        break;
      default:
        appFlavor = Flavor.production;
    }
  }
}
