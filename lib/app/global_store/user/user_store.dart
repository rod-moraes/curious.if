import 'package:mobx/mobx.dart';

import '../../domain/auth/model/user_model.dart';
part 'user_store.g.dart';

class UserStore extends _UserStoreBase with _$UserStore {}

abstract class _UserStoreBase with Store {
  @observable
  UserModel? userModel;

  @action
  void logout() {
    userModel = null;
  }

  @action
  void login(UserModel user) {
    userModel = user;
  }

  @computed
  bool get isLogged => userModel != null;
}
