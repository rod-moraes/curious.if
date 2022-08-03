// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$stateAtom = Atom(name: '_AuthStoreBase.state', context: context);

  @override
  AuthState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AuthState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$authAsyncAction =
      AsyncAction('_AuthStoreBase.auth', context: context);

  @override
  Future<void> auth({required AuthModel authModel}) {
    return _$authAsyncAction.run(() => super.auth(authModel: authModel));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
