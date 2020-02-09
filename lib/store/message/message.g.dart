// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Message on MessageMobx, Store {
  final _$messageDataAtom = Atom(name: 'MessageMobx.messageData');

  @override
  List<dynamic> get messageData {
    _$messageDataAtom.context.enforceReadPolicy(_$messageDataAtom);
    _$messageDataAtom.reportObserved();
    return super.messageData;
  }

  @override
  set messageData(List<dynamic> value) {
    _$messageDataAtom.context.conditionallyRunInAction(() {
      super.messageData = value;
      _$messageDataAtom.reportChanged();
    }, _$messageDataAtom, name: '${_$messageDataAtom.name}_set');
  }

  final _$MessageMobxActionController = ActionController(name: 'MessageMobx');

  @override
  void set(dynamic value) {
    final _$actionInfo = _$MessageMobxActionController.startAction();
    try {
      return super.set(value);
    } finally {
      _$MessageMobxActionController.endAction(_$actionInfo);
    }
  }
}
