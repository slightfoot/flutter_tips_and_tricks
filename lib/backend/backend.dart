import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tips_and_tricks/models/user.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _userKey = 'user';

class Backend {
  Backend._({
    required SharedPreferences prefs,
    required User user,
  })  : _prefs = prefs,
        _userSubject = BehaviorSubject<User>.seeded(user);

  final SharedPreferences _prefs;
  final BehaviorSubject<User> _userSubject;

  static Future<Backend> init() async {
    final prefs = await SharedPreferences.getInstance();
    User user;
    try {
      final userData = prefs.getString(_userKey);
      if (userData != null) {
        user = User.fromJson(json.decode(userData));
      } else {
        user = User.empty;
      }
    } catch (error) {
      prefs.remove(_userKey);
      user = User.empty;
    }
    return Backend._(
      prefs: prefs,
      user: user,
    );
  }

  User get userCurrent => _userSubject.value;

  Stream<User> get userStream => _userSubject.stream;

  void dispose() {
    if (userCurrent != User.empty) {
      _prefs.setString(_userKey, json.encode(userCurrent));
    } else {
      _prefs.remove(_userKey);
    }
  }
}

mixin BackendMixin<T extends StatefulWidget> on State<T> {
  late final backend = context.backend;
}

extension BackendBuildContext on BuildContext {
  Backend get backend => Provider.of<Backend>(this);
}
