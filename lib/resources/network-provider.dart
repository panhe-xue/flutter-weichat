import 'dart:async';
import 'base-api-provider.dart';

class NetworkProvider extends BaseApiProvider {
  static String baseUrl = 'http://localhost:8000';
  // 登录
  Future<String> login(Map<String, dynamic> params) async {
    final response = await post('$baseUrl/login', params);
    return response.toString();
  }

  // 上传图片
  Future<String> uploadImage(params) async {
    final response = await post('$baseUrl/upload', params);
    return response.toString();
  }

  // 注册
  Future<String> register(params) async {
    final response = await post('$baseUrl/register', params);
    return response.toString();
  }

  // 获取聊天信息
  Future<String> getChatMsg() async {
    final response = await get('$baseUrl/getChatMsg');
    return response.toString();
  }

  // 获取添加新的好友历史记录
  Future<String> getNewFriendList() async {
    final response = await get('$baseUrl/getNewFriendList');
    return response.toString();
  }

  // 获取好友列表
  Future<String> getRelationship() async {
    final response = await get('$baseUrl/getRelationship');
    return response.toString();
  }

  // 搜索好友
  Future<String> searchFriend(params) async {
    final response = await get('$baseUrl/searchFriend', params);
    return response.toString();
  }
  // 添加好友
  Future<String> addFriend(params) async {
    final response = await get('$baseUrl/addFriend', params);
    return response.toString();
  }
}