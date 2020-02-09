// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newFriend.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewFriend on NewFriendMobx, Store {
  final _$newFriendDataAtom = Atom(name: 'NewFriendMobx.newFriendData');

  @override
  List<dynamic> get newFriendData {
    _$newFriendDataAtom.context.enforceReadPolicy(_$newFriendDataAtom);
    _$newFriendDataAtom.reportObserved();
    return super.newFriendData;
  }

  @override
  set newFriendData(List<dynamic> value) {
    _$newFriendDataAtom.context.conditionallyRunInAction(() {
      super.newFriendData = value;
      _$newFriendDataAtom.reportChanged();
    }, _$newFriendDataAtom, name: '${_$newFriendDataAtom.name}_set');
  }

  final _$newFriendDataCountAtom =
      Atom(name: 'NewFriendMobx.newFriendDataCount');

  @override
  int get newFriendDataCount {
    _$newFriendDataCountAtom.context
        .enforceReadPolicy(_$newFriendDataCountAtom);
    _$newFriendDataCountAtom.reportObserved();
    return super.newFriendDataCount;
  }

  @override
  set newFriendDataCount(int value) {
    _$newFriendDataCountAtom.context.conditionallyRunInAction(() {
      super.newFriendDataCount = value;
      _$newFriendDataCountAtom.reportChanged();
    }, _$newFriendDataCountAtom, name: '${_$newFriendDataCountAtom.name}_set');
  }

  final _$NewFriendMobxActionController =
      ActionController(name: 'NewFriendMobx');

  @override
  void reCount() {
    final _$actionInfo = _$NewFriendMobxActionController.startAction();
    try {
      return super.reCount();
    } finally {
      _$NewFriendMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void set(dynamic value) {
    final _$actionInfo = _$NewFriendMobxActionController.startAction();
    try {
      return super.set(value);
    } finally {
      _$NewFriendMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFirst(dynamic value) {
    final _$actionInfo = _$NewFriendMobxActionController.startAction();
    try {
      return super.setFirst(value);
    } finally {
      _$NewFriendMobxActionController.endAction(_$actionInfo);
    }
  }
}
