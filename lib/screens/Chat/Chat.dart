import 'package:flutter/material.dart';
import './EntryItem.dart';
import 'package:weichat/store/message/message.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weichat/resources/io-client.dart';
class ChatPage extends StatefulWidget {
  final int index;
  ChatPage(this.index);
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage> {
  @override
  void dispose() {
    message.exitChatPage();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    final TextEditingController _textController = TextEditingController();
    void _handleSubmitted() {
      var text = _textController.text;
      _textController.clear();
      var scoket = IOClient.getInstance();
      if(text == null || text == '') return;
      message.sendChatMsg(Chat(
        text,
        true
      ), scoket, widget.index);
    }
    Widget _buildTextComposer() {
      return new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(children: <Widget>[
          new Flexible(
            child: new TextField(
              controller: _textController,
              decoration: new InputDecoration.collapsed(hintText: '发送消息')
            ),
          ),
          new Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(Icons.send, color: Colors.blue),
              onPressed: () {
                _handleSubmitted();
              },
            )
          )
        ])
      );
    }

    Widget divider = Divider(color: Color(0xFFebebeb), height: 18.0, indent: 18);
    return new Scaffold(
      appBar: new AppBar(
        title: Observer(builder: (_) => new Text(message.currentChatMessage.nickname)),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFebebeb)
        ),
        child: new Column(children: <Widget>[
          new Flexible(
            child: Observer(builder: (_) => new ListView.separated(
              separatorBuilder: (BuildContext context, index) {
                return divider;
              },
              padding: new EdgeInsets.all(8.0),
              // reverse: true,
              itemBuilder: (BuildContext context, int index) {
                return EntryItem(message.currentChatHistory[index]);
              },
              itemCount: message.currentChatHistory.length,
            )),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ]),
      )
    );
  }
}