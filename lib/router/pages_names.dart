enum PAGESNAMES {
  splashScreen,
  home,
  login,
  onbroading,
  mentalHealth,
  mentalHealthCounting,
  mentalHealthResult,
  depression,
  depressionCounting,
  depressionResult,
  anxiety,
  stress,
  tips,
  tipDetails,
  about,
  support,
  history
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
      case PAGESNAMES.depressionCounting:
        return '/depressionCounting';
      case PAGESNAMES.depressionResult:
        return '/depressionResult';
      case PAGESNAMES.anxiety:
        return '/anxiety';
      case PAGESNAMES.stress:
        return '/stress';
      case PAGESNAMES.tips:
        return '/tips';
      case PAGESNAMES.tipDetails:
        return '/tipDetails';
      case PAGESNAMES.about:
        return '/about';
      case PAGESNAMES.support:
        return '/support';
      case PAGESNAMES.history:
        return '/history';
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
      case PAGESNAMES.depressionCounting:
        return 'depressionCounting';
      case PAGESNAMES.depressionResult:
        return 'depressionResult';
      case PAGESNAMES.anxiety:
        return 'anxiety';
      case PAGESNAMES.stress:
        return 'stress';
      case PAGESNAMES.tips:
        return 'tips';
      case PAGESNAMES.tipDetails:
        return 'tipDetails';
      case PAGESNAMES.about:
        return 'about';
      case PAGESNAMES.support:
        return 'support';
      case PAGESNAMES.history:
        return 'history';
    }
  }
}