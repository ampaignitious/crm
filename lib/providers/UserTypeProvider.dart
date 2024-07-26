import 'package:flutter/foundation.dart';

class UserTypeProvider with ChangeNotifier {
  bool _userType = false; // Default to normal user type

  bool get userType => _userType;

  void setUserType(bool userType) {
    _userType = userType;
    notifyListeners();
  }
}
