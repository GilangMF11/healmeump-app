enum PAGESNAMES {
  splashScreen,
  home,
  login,
  onbroading,
  mentalHealth,
  mentalHealthCounting,
  mentalHealthResult,
  depression,
  anxiety,
  stress,
  tips,
  tipDetails

}

extension AppPageExtension on PAGESNAMES {
  String get ScreenPath {
    switch (this) {
      case PAGESNAMES.splashScreen:
        return '/SplashScreen';
      case PAGESNAMES.login:
        return '/login';
      case PAGESNAMES.home:
        return '/home';
      case PAGESNAMES.onbroading:
        return '/onbroading';
      case PAGESNAMES.mentalHealth:
        return '/mentalHealth';
      case PAGESNAMES.mentalHealthCounting:
        return '/mentalHealthCounting';
      case PAGESNAMES.mentalHealthResult:
        return '/mentalHealthResult';
      case PAGESNAMES.depression:
        return '/depression';
      case PAGESNAMES.anxiety:
        return '/anxiety';
      case PAGESNAMES.stress:
        return '/stress';
      case PAGESNAMES.tips:
        return '/tips';
      case PAGESNAMES.tipDetails:
        return '/tipDetails';
      }
  }

  String get ScreenName {
    switch (this) {
      case PAGESNAMES.splashScreen:
        return 'SplashScreen';
      case PAGESNAMES.login:
        return 'login';
      case PAGESNAMES.home:
        return 'home';
      case PAGESNAMES.onbroading:
        return 'onbroading';
      case PAGESNAMES.mentalHealth:
        return 'mentalHealth';
      case PAGESNAMES.mentalHealthCounting:
        return 'mentalHealthCounting';
      case PAGESNAMES.mentalHealthResult:
        return 'mentalHealthResult';
      case PAGESNAMES.depression:
        return 'depression';
      case PAGESNAMES.anxiety:
        return 'anxiety';
      case PAGESNAMES.stress:
        return 'stress';
      case PAGESNAMES.tips:
        return 'tips';
      case PAGESNAMES.tipDetails:
        return 'tipDetails';
    }
  }
}