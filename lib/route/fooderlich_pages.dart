class AppLink {
  static const String splashPath = '/splash';
  static const String home = '/home';
  static const String fightPath = '/fight';
  static const String statisticPath = '/statistic';

  String? location;

  AppLink({this.location});

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');

    final uri = Uri.parse(location);

    final link = AppLink(
      location: uri.path,
    );

    return link;
  }

  String toLocation() {
    switch (location) {
      case splashPath:
        return splashPath;
      case home:
        return home;
      case fightPath:
        return fightPath;
      case statisticPath:
        return statisticPath;
      default:
        return home;
    }
  }
}
