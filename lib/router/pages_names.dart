enum PAGESNAMES {
  splashScreen,
  home,
  login,
  onbroading,
  

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
    }
  }
}