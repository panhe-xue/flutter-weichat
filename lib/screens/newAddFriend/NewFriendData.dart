class NewFriendData {
  int uid;
  String avatar;
  String nickname;
  int status; // 0 没有处理 // 1接受 // 3拒绝
  NewFriendData(this.uid, this.avatar, this.nickname, this.status);
}