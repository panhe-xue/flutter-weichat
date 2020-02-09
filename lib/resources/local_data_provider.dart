
import 'package:weichat/resources/shared_preferences.dart';

class SharedPreferencesKeys {
  static String uid            = 'uid';
  static String nickname   = 'nickname';
  static String avatar     = 'avatar';
  static String phone      = 'phone';
  static String qrcode     = 'qrcode';
  static String gender     = 'gender';
  static String token      = 'token';
  static String contexts   = 'contexts';
  static String _isAndroid = '_isAndroid';
}

class UserBriefModel {
  int uid;
  String nickname;
  String avatar;
  String qrcode;
  String phone;
  int gender;
  Map toJson() {
    Map map = new Map();
    map['nickname'] = this.nickname;
    map['avatar']   = this.avatar;
    map['qrcode']   = this.qrcode;
    map['phone']    = this.phone;
    map['gender']   = this.gender;
    return map;
  }
}

class LocalDataProvider {
  UserBriefModel _briefInfo;
  SpUtil sp;
  static LocalDataProvider _instance;
  // 单利
  static LocalDataProvider getInstance() {
    if (_instance == null) {
      _instance = LocalDataProvider();
    }
    return _instance;
  }

  initData() async {
    sp = await SpUtil.getInstance();
    _briefInfo = UserBriefModel();
    clearAll();
    initBriefInfo();
  }

  initBriefInfo() {
    _briefInfo.uid      = sp.getInt(SharedPreferencesKeys.uid);
    _briefInfo.nickname = sp.getString(SharedPreferencesKeys.nickname);
    _briefInfo.phone    = sp.getString(SharedPreferencesKeys.phone);
    _briefInfo.avatar   = sp.getString(SharedPreferencesKeys.avatar);
    _briefInfo.qrcode   = sp.getString(SharedPreferencesKeys.qrcode);
    _briefInfo.gender   = sp.getInt(SharedPreferencesKeys.gender);
  }

  saveUserInfo(body) async {
    sp.putInt(SharedPreferencesKeys.uid, body['id']);
    sp.putString(SharedPreferencesKeys.nickname, body['nickname']);
    sp.putString(SharedPreferencesKeys.phone,    body['phone']);
    sp.putString(SharedPreferencesKeys.avatar,   body['avatar']);
    sp.putString(SharedPreferencesKeys.qrcode,   body['qrcode']);
    sp.putInt(SharedPreferencesKeys.gender,   body['gender']);
    initBriefInfo();
  }
  bool isLogin() {
    if (null == _briefInfo.phone) {
      return false;
    } else {
      return true;
    }
  }

  // token
  setToken(String token) {
    sp.putString(SharedPreferencesKeys.token, token);
  }

  getToken() {
    return sp.getString(SharedPreferencesKeys.token);
  }
  setContext(String contexts) {
    sp.putString(SharedPreferencesKeys.contexts, contexts);
  }

  getContext() {
    return sp.getString(SharedPreferencesKeys.contexts);
  }

  setIos() {
    sp.putBool(SharedPreferencesKeys._isAndroid, false);
  }

  isAndroid() {
    return sp.getBool(SharedPreferencesKeys._isAndroid);
  }

  getNickName() {
    return _briefInfo.nickname;
  }

  getUid() {
    return _briefInfo.uid;
  }

  getAccount() {
    return _briefInfo.phone;
  }

  getAvatar() {
    return _briefInfo.avatar;
  }
  getGender() {
    return _briefInfo.gender;
  }

  clearAll() {
    _briefInfo.uid      = null;
    _briefInfo.nickname = null;
    _briefInfo.phone    = null;
    _briefInfo.avatar   = null;
    _briefInfo.phone    = null;
    _briefInfo.qrcode   = null;
    _briefInfo.gender   = null;
    sp.clear();
  }

}
