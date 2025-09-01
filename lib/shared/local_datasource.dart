import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  late final SharedPreferences sharedPrefs;

  static final LocalDataSource _instance = LocalDataSource._internal();
  factory LocalDataSource() => _instance;
  LocalDataSource._internal();

  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.token, token ?? "");
  }

  Future<void> saveName(String? name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.name, name ?? "");
  }

  Future<void> saveEmail(String? email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.email, email ?? "");
  }

  Future<void> savePassword(String? password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.password, password ?? "");
  }

  Future<void> saveType(String? type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.type, type ?? "");
  }

  Future<void> saveStudyProgram(String? studyProgram) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.studyProgram, studyProgram ?? "");
  }

  Future<void> saveFaculty(String? faculty) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.faculty, faculty ?? "");
  }

  Future<void> saveUsername(String? username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.username, username ?? "");
  }

  Future<void> savePhoneNumber(String? phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.phoneNumber, phoneNumber ?? "");
  }

  Future<void> saveGender(String? gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.gender, gender ?? "");
  }

  Future<void> saveTglLahir(String? tglLahir) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.tglLahir, tglLahir ?? "");
  }

  Future<void> savePhoto(String? photo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.photo, photo ?? "");
  }

  Future<void> saveVersion(String? version) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.version, version ?? "");
  }

  Future<void> saveLinkApp(String? linkApp) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.linkApp, linkApp ?? "");
  }

  Future<void> saveStatusToken(String? statusToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.statusToken, statusToken ?? "");
  }

  void saveLogIn(bool isLogin) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ConstSharePreferences.isLogin, isLogin);
  }

  void saveIsMember(bool isMember) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(ConstSharePreferences.isMember, isMember);
  }

  Future<void> saveRoleUser(String? roleUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(ConstSharePreferences.roleUser, roleUser ?? "");
  }


  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ConstSharePreferences.token);
    return token ?? "";
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString(ConstSharePreferences.name);
    return name ?? "";
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString(ConstSharePreferences.email);
    return email ?? "";
  }

  Future<String> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(ConstSharePreferences.username);
    return username ?? "";
  }

  Future<String> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString(ConstSharePreferences.password);
    return password ?? "";
  }

  Future<String> getType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? type = prefs.getString(ConstSharePreferences.type);
    return type ?? "";
  }

  Future<String> getStudyProgram() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studyProgram = prefs.getString(ConstSharePreferences.studyProgram);
    return studyProgram ?? "";
  }

  Future<String> getFaculty() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? faculty = prefs.getString(ConstSharePreferences.faculty);
    return faculty ?? "";
  }

  Future<String> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? phoneNumber = prefs.getString(ConstSharePreferences.phoneNumber);
    return phoneNumber ?? "";
  }

  Future<String> getGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? gender = prefs.getString(ConstSharePreferences.gender);
    return gender ?? "";
  }

  Future<String> getTglLahir() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tglLahir = prefs.getString(ConstSharePreferences.tglLahir);
    return tglLahir ?? "";
  }


  Future<String> getPhoto() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? photo = prefs.getString(ConstSharePreferences.photo);
    return photo ?? "";
  }

  Future<String> getVersion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? version = prefs.getString(ConstSharePreferences.version);
    return version ?? "";
  }

  Future<String> getLinkApp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? linkApp = prefs.getString(ConstSharePreferences.linkApp);
    return linkApp ?? "";
  }

  Future<String> getStatusToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? statusToken = prefs.getString(ConstSharePreferences.statusToken);
    return statusToken ?? "";
  }

  Future<bool> getIsMember() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isMember = prefs.getBool(ConstSharePreferences.isMember);
    return isMember ?? false;
  }

  Future<bool> getIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool(ConstSharePreferences.isLogin);
    return isLogin ?? false;
  }

  Future<String> getRoleUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roleUser = prefs.getString(ConstSharePreferences.roleUser);
    return roleUser ?? "";
  }

  // Future<void> savePhotoProfile(String dataProfile) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString(ConstSharePreferences.keyImg, jsonEncode(dataProfile));
  // }

  // Future<String?> geImgProfile() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? keyProfile = prefs.getString(ConstSharePreferences.keyImg);
  //   return keyProfile ?? "";
  // }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  String formatPhoneNumber(String username) {
    // Langkah 1: Ganti awalan '62' dengan '0'
    String updatedUsername = username.replaceFirst('62', '0');

    // Langkah 2: Hapus '@c.us'
    updatedUsername = updatedUsername.replaceAll('@c.us', '');

    return updatedUsername;
  }
}

class ConstSharePreferences {
  static String token = 'token';
  static String roleUser = 'roleUser';
  static String name = 'name';
  static String username = 'username';
  static String password = 'password';
  static String type = 'type';
  static String studyProgram = 'studyProgram';
  static String faculty = 'faculty';
  static String email = 'email';
  static String phoneNumber = 'phoneNumber';
  static String gender = 'gender';
  static String tglLahir = 'tglLahir';
  static String photo = 'photo';
  static String version = 'version';
  static String linkApp = 'linkApp';
  static String statusToken = 'statusToken';
  static String isMember = 'isMember';
  static String isLogin = 'isLogin';
}
