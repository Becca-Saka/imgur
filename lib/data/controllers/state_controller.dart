import 'package:flutter/widgets.dart';
import 'package:imgur/app/appstate.dart';

class StateController extends ChangeNotifier {
  AppState  _state = AppState.idle;

  AppState get state => _state;

  void setAppState(AppState viewState) {
    _state = viewState;
    notifyListeners();
  }
  
}