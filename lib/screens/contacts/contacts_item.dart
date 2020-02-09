import 'package:flutter/material.dart';
import './contact_vo.dart';
class ContactsItem extends StatelessWidget {
  final ContactData contactsData;
  ContactsItem(this.contactsData);
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new Image.network(this.contactsData.avatar, width: 40.0, height: 40.0),
      title: new Text(this.contactsData.nickname)
    );
  }
}