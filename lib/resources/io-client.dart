import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/store/message/message.dart';
import 'package:weichat/store/newFriend/contact.dart';
import 'package:weichat/store/newFriend/newFriend.dart';
import 'package:weichat/screens/newAddFriend/NewFriendData.dart';

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
          String action = msg["data"]["action"];
          var payload = msg["data"]["payload"];
          if(action == 'exchange') {
            message.receiverChatMsg(msg);
          } else if(action == 'addFriend') {
            newFriend.setFirst(
              NewFriendData(
                payload["sender"],
                payload["avatar"],
                payload["nickname"],
                0,
              )
            );
          }
        });
        // 登录
        socket.emit('login', {
          'uid': uid
        });

        // 待开发功能，更新uid对应的socketId
        socket.on('changeSocketId', (msg){
          message.changeNewsocketId(msg);
          contact.changeNewsocketId(msg);
        });
      });
      socket.on('disconnect', (_) => print('disconnect'));
    }
    return socket;
  }

}