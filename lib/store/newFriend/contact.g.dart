// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Contact on ContactMobx, Store {
  final _$contactsDataAtom = Atom(name: 'ContactMobx.contactsData');

  @override
  List<dynamic> get contactsData {
    _$contactsDataAtom.context.enforceReadPolicy(_$contactsDataAtom);
    _$contactsDataAtom.reportObserved();
    return super.contactsData;
  }

  @override
  set contactsData(List<dynamic> value) {
    _$contactsDataAtom.context.conditionallyRunInAction(() {
      super.contactsData = value;
      _$contactsDataAtom.reportChanged();
    }, _$contactsDataAtom, name: '${_$contactsDataAtom.name}_set');
  }

  final _$ContactMobxActionController = ActionController(name: 'ContactMobx');

  @override
  void set(dynamic value) {
    final _$actionInfo = _$ContactMobxActionController.startAction();
    try {
      return super.set(value);
    } finally {
      _$ContactMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirst(dynamic value) {
    final _$actionInfo = _$ContactMobxActionController.startAction();
    try {
      return super.setFirst(value);
    } finally {
      _$ContactMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic isInMessageList(dynamic uid) {
    final _$actionInfo = _$ContactMobxActionController.startAction();
    try {
      return super.isInMessageList(uid);
    } finally {
      _$ContactMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeNewsocketId(dynamic data) {
    final _$actionInfo = _$ContactMobxActionController.startAction();
    try {
      return super.changeNewsocketId(data);
    } finally {
      _$ContactMobxActionController.endAction(_$actionInfo);
    }
  }
}
