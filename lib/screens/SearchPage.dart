import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weichat/resources/network-provider.dart';
import 'package:weichat/screens/FriendDetail.dart';
import 'package:weichat/screens/newAddFriend/newFriend_item.dart';
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/store/newFriend/newFriend.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchFriendPage extends StatefulWidget {
  @override
  bool showNewFriendsList = false;

  SearchFriendPage({Key key, this.showNewFriendsList}): super(key: key);
  SearchFriendPageState createState() => SearchFriendPageState();
}

class SearchFriendPageState extends State<SearchFriendPage> {
  bool hasNoSend = false;
  bool hasNoFriend = false;
  String _searchContent = '';
  final TextEditingController _searchController = TextEditingController();

  Widget wirteContent() {
    return GestureDetector(
      onTap: () async {
        print(_searchContent);
        // 发送好友申请
        var params = {
          'keyword': _searchContent
        };
        var res = await NetworkProvider().searchFriend(params);
        var data = json.decode(res);
        var ret = data['ret'];
        var friendMessage = data['data'];
        if(ret == 0 && friendMessage != null) {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new FriendDetail(
                sender: LocalDataProvider.getInstance().getUid(),
                receiver: friendMessage['id'],
                nickname: friendMessage['nickname'],
                account: friendMessage['phone'],
                avatar: friendMessage['avatar'],
                gender: friendMessage['gender'],
                socketId: friendMessage['socket_id'],
                isFriends: friendMessage['isFriends']
              )
            )
          );
        } else {
          Future.delayed(Duration(milliseconds: 200)).then((e) {
            setState(() {
              hasNoFriend = true;
              hasNoSend = false;
            });
          });
        }
      },
      child: Container(
        margin: new EdgeInsets.only(top: 10.0),
        padding: new EdgeInsets.fromLTRB(10, 10, 0, 10),
        height: 60.0,
        alignment: Alignment.centerLeft,
        decoration: new BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Container(child: Image.asset('images/addperson.png', width: 40),margin: const EdgeInsets.only(right: 10)),
            Text('搜索：'),
            Text(_searchContent, style: TextStyle(color: Colors.blue.shade300, fontSize: 15),),
          ],
        ),
      ),
    );
  }

  Widget noFriends() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      decoration: new BoxDecoration(
        color: Color(0XFFFFF8F4),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 40, bottom: 40),
        child: Center(child: Text('用户不存在',style: TextStyle(color: Colors.grey.shade300))),
      ),
    );
  }

  Widget newFriendList() {

    return Flexible(
      child: Observer(builder: (_) => ListView.builder(
        itemCount: newFriend.newFriendData.length,
        itemBuilder: (BuildContext context, int index) {
          return NewFriendItem(newFriend.newFriendData[index]);
        }
      )));
  }

  Widget _finalShow() {
    if(hasNoSend == true) {
      return wirteContent();
    }
    if(hasNoFriend == true) {
      return noFriends();
    }
    if(widget.showNewFriendsList == true) {
      Future.delayed(Duration(milliseconds: 200)).then((e) {
        newFriend.reCount();
      });
      return newFriendList();
    }
    return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 45.0),
        decoration: new BoxDecoration(
          color: Colors.grey.shade300
        ),
        child: Column(children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 35.0),
                      child: TextField(
                        onChanged: (text) {
                          Future.delayed(Duration(milliseconds: 200)).then((e) {
                            setState(() {
                            if(text != '') {
                              hasNoSend = true;
                            } else {
                              hasNoSend = false;
                            }
                            hasNoFriend = false;
                            widget.showNewFriendsList = false;
                              _searchContent = text;
                            });
                          });
                        },
                        autocorrect: true,
                        controller: _searchController,
                        style: TextStyle(color: Colors.black),
                        decoration: new InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                          fillColor: Color(0XFFFFF8F4),
                          filled: true,
                          hintText: '手机号',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none
                          ),
                          prefixIcon: Icon(Icons.search)
                        ),
                      ),
                    ),
                  )
                ),
                Container(
                  width: 40,
                  margin: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    child: Text('取消', style: TextStyle(color: Colors.blue.shade300)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          _finalShow()
        ],),
      ),
    );
  }
}