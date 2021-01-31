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

  void subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
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
    message["action"] = "onMessage";
    _streamMessagesController.sink.add(message);
  }

  Future<dynamic> onLaunch(Map<String, dynamic> message) async {
    print("======== onLaunch ========");
    message["action"] = "onLaunch";
    _streamMessagesController.sink.add(message);
  }

  Future<dynamic> onResume(Map<String, dynamic> message) async {
    print("======== onResume ========");
    message["action"] = "onResume";
    _streamMessagesController.sink.add(message);
  }

  dispose() {
    _streamMessagesController?.close();
  }
}
