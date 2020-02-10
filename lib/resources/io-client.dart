import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/resources/event-bus.dart';

class MessageBean {
  String target;
  String text;
  MessageBean(this.target, this.text);
}

class IOClient {
  static String api = 'http://localhost:8000';
  static IO.Socket socket;
  static getInstance([var uid ]) {
    if(socket == null) {
      socket = IO.io(api, <String, dynamic> {
        'transports': ['websocket'],
        'extraHeaders': {'token': LocalDataProvider.getInstance().getToken() }
      });

      socket.on('connect', (_) {
        var id = socket.id;
        socket.on(id, (msg){
          eventBus.fire(new MessageEvent(msg));
        });
        // 加好友监听
        socket.on('addFriend', (msg){
          eventBus.fire(new AddFriendEvent(
            msg.uid,
            msg.nickname,
            msg.avatar
          ));
        });
        // 登录
        socket.emit('login', {
          'uid': uid
        });

        // 待开发功能，更新uid对应的socketId

      });
      socket.on('disconnect', (_) => print('disconnect'));
    }
    return socket;
  }

  // static sendAddFriend(messageBean) {
  //   //实时更新到聊天界面
  //   if (socketed == null) {
  //     IOClient.getInstance();
  //   }
  //   print(messageBean);
  //   socketed.emit('addFriend', {
  //     'target': messageBean.target,
  //     'payload': {
  //       'uid' : messageBean.id,
  //       'nickname' : messageBean.nickname,
  //       'avatar' : messageBean.avatar
  //     },
  //   });
  // }

}