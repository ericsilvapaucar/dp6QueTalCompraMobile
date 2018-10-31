
import 'package:que_tal_compra/services/login.dart';

abstract class MainViewContract {

  void onLoadedUser(User user);
  void onFailedUser();

}

class MainPresenter {

  MainViewContract _view;

  MainPresenter(this._view);

  void loadUser() {

    assert(_view != null);

    var userManager = UserManager.instance;
    var user = userManager.user;

    _view.onLoadedUser(user);

//    if (user != null) {
//      _view.onLoadedUser(user);
//    } else {
//      _view.onFailedUser();
//    }

  }

}