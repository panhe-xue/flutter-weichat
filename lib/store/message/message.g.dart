// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Message on MessageMobx, Store {
  final _$currentChatMessageAtom = Atom(name: 'MessageMobx.currentChatMessage');

  @override
  ChatPersonDetail get currentChatMessage {
    _$currentChatMessageAtom.context
        .enforceReadPolicy(_$currentChatMessageAtom);
    _$currentChatMessageAtom.reportObserved();
    return super.currentChatMessage;
  }

  @override
  set currentChatMessage(ChatPersonDetail value) {
    _$currentChatMessageAtom.context.conditionallyRunInAction(() {
      super.currentChatMessage = value;
      _$currentChatMessageAtom.reportChanged();
    }, _$currentChatMessageAtom, name: '${_$currentChatMessageAtom.name}_set');
  }

  final _$messageListAtom = Atom(name: 'MessageMobx.messageList');

  @override
  List<MessageListItem> get messageList {
    _$messageListAtom.context.enforceReadPolicy(_$messageListAtom);
    _$messageListAtom.reportObserved();
    return super.messageList;
  }

  @override
  set messageList(List<MessageListItem> value) {
    _$messageListAtom.context.conditionallyRunInAction(() {
      super.messageList = value;
      _$messageListAtom.reportChanged();
    }, _$messageListAtom, name: '${_$messageListAtom.name}_set');
  }

  final _$currentChatHistoryAtom = Atom(name: 'MessageMobx.currentChatHistory');

  @override
  List<Chat> get currentChatHistory {
    _$currentChatHistoryAtom.context
        .enforceReadPolicy(_$currentChatHistoryAtom);
    _$currentChatHistoryAtom.reportObserved();
    return super.currentChatHistory;
  }

  @override
  set currentChatHistory(List<Chat> value) {
    _$currentChatHistoryAtom.context.conditionallyRunInAction(() {
      super.currentChatHistory = value;
      _$currentChatHistoryAtom.reportChanged();
    }, _$currentChatHistoryAtom, name: '${_$currentChatHistoryAtom.name}_set');
  }

  final _$messageRecordMapAtom = Atom(name: 'MessageMobx.messageRecordMap');

  @override
  Map<dynamic, dynamic> get messageRecordMap {
    _$messageRecordMapAtom.context.enforceReadPolicy(_$messageRecordMapAtom);
    _$messageRecordMapAtom.reportObserved();
    return super.messageRecordMap;
  }

  @override
  set messageRecordMap(Map<dynamic, dynamic> value) {
    _$messageRecordMapAtom.context.conditionallyRunInAction(() {
      super.messageRecordMap = value;
      _$messageRecordMapAtom.reportChanged();
    }, _$messageRecordMapAtom, name: '${_$messageRecordMapAtom.name}_set');
  }

  final _$badgeCountMapAtom = Atom(name: 'MessageMobx.badgeCountMap');

  @override
  Map<dynamic, dynamic> get badgeCountMap {
    _$badgeCountMapAtom.context.enforceReadPolicy(_$badgeCountMapAtom);
    _$badgeCountMapAtom.reportObserved();
    return super.badgeCountMap;
  }

  @override
  set badgeCountMap(Map<dynamic, dynamic> value) {
    _$badgeCountMapAtom.context.conditionallyRunInAction(() {
      super.badgeCountMap = value;
      _$badgeCountMapAtom.reportChanged();
    }, _$badgeCountMapAtom, name: '${_$badgeCountMapAtom.name}_set');
  }

  final _$MessageMobxActionController = ActionController(name: 'MessageMobx');

  @override
  dynamic enterChatPage(int uid, ChatPersonDetail msg) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.enterChatPage(uid, msg);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic sendChatMsg(Chat msg, dynamic socket) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.sendChatMsg(msg, socket);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic receiverChatMsg(dynamic data) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.receiverChatMsg(data);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getCurrentMessage(ChatPersonDetail msg) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.getCurrentMessage(msg);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic restCurrentMessage() {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.restCurrentMessage();
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addMessageList(MessageListItem v) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.addMessageList(v);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addCurrentChatHistory(Chat v) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.addCurrentChatHistory(v);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addMessageRecordMap(int uid, Chat v) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.addMessageRecordMap(uid, v);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic restCurrentChatHistory() {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.restCurrentChatHistory();
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getCurrentChatHistory(int uid) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.getCurrentChatHistory(uid);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeBadgeCount(int uid) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.changeBadgeCount(uid);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }
}
