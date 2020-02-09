import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './contacts_header.dart';
import './contacts_item.dart';
import 'package:weichat/screens/FriendDetail.dart';
import 'package:weichat/resources/local_data_provider.dart';
import 'package:weichat/store/newFriend/contact.dart';
import 'package:weichat/store/newFriend/newFriend.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weichat/resources/event-bus.dart';
import 'package:weichat/screens/newAddFriend/newFriend_vo.dart';

class FriendListScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FriendListScreenState();
  }
}

class FriendListScreenState extends State {
  var loginSubscription;
  @override
  void initState() {
    loginSubscription= eventBus.on<AddFriendEvent>().listen((event) {
      print('触发了啊....................');
      print(event);
      newFriend.setFirst(
        NewFriendData(
          event.uid,
          event.avatar,
          event.nickname,
          0,
          0
        )
      );
    });
    super.initState();
  }

  @override
  void dispose() {
  loginSubscription.cancel();
  super.dispose();
  }

  _shouldShowHeader(int position) {
    if(position<=0) return false;
    if(position!=0 && contact.contactsData[position].sessionKey != contact.contactsData[position-1].sessionKey) return false;
    return true;
  }
  Widget _showHeader(int index) {
    if(index == 0) {
      return ContactHeader();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title:  Text("通讯录"),
        centerTitle: false,
        // backgroundColor: Colors.grey,
      ),
      body: Observer(builder: (_) => new ListView.builder(
        itemCount: contact.contactsData.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(children: <Widget>[
            _showHeader(index),
            Offstage(
              offstage: _shouldShowHeader(index),
              child: Container(
                height: 32.0,
                padding: const EdgeInsets.only(left: 13.0),
                color: Colors.grey[300],
                alignment: Alignment.centerLeft,
                child: Text(contact.contactsData[index].sessionKey)),
            ),
            new GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new FriendDetail(
                      sender: LocalDataProvider.getInstance().getUid(),
                      receicer: contact.contactsData[index].uid,
                      nickname: contact.contactsData[index].nickname,
                      account: contact.contactsData[index].phone,
                      avatar: contact.contactsData[index].avatar,
                      gender: contact.contactsData[index].gender,
                      socketId: contact.contactsData[index].socketId,
                      isFriends: true
                    )
                  )
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom:  BorderSide(width: 0.5, color: Color(0xFFd9d9d9)))
                ),
                child: ContactsItem(contact.contactsData[index]),
              ),
            )
          ]);
        },
      ))
    );
  }
}