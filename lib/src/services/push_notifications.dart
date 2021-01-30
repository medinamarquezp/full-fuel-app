import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _streamMessagesController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get streamMessages =>
      _streamMessagesController.stream;

  static Future<dynamic> onBackgroundMessage(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      final dynamic data = message['data'];
    }
    if (message.containsKey('notification')) {
      final dynamic notification = message['notification'];
    }
  }

  initNotifications() async {
    await _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure(
      onMessage: onMessage,
      onBackgroundMessage: onBackgroundMessage,
      onLaunch: onLaunch,
      onResume: onResume,
    );
  }

  Future<dynamic> onMessage(Map<String, dynamic> message) async {
    print("======== onMessage ========");
    _streamMessagesController.sink.add(message);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("======== onLaunch ========");
    _streamMessagesController.sink.add(message);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("======== onResume ========");
    _streamMessagesController.sink.add(message);
  }

  dispose() {
    _streamMessagesController?.close();
  }
}
