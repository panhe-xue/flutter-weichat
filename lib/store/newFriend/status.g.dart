// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Status on StatusMobx, Store {
  final _$statusAtom = Atom(name: 'StatusMobx.status');

  @override
  int get status {
    _$statusAtom.context.enforceReadPolicy(_$statusAtom);
    _$statusAtom.reportObserved();
    return super.status;
  }

  @override
  set status(int value) {
    _$statusAtom.context.conditionallyRunInAction(() {
      super.status = value;
      _$statusAtom.reportChanged();
    }, _$statusAtom, name: '${_$statusAtom.name}_set');
  }

  final _$StatusMobxActionController = ActionController(name: 'StatusMobx');

  @override
  void set(int value) {
    final _$actionInfo = _$StatusMobxActionController.startAction();
    try {
      return super.set(value);
    } finally {
      _$StatusMobxActionController.endAction(_$actionInfo);
    }
  }
}
