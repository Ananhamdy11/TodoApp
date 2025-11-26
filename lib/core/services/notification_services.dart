import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    tz.setLocalLocation(tz.getLocation(tz.local.name));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);
  }

  static Future<void> scheduleTodoNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final tz.TZDateTime tzTime = tz.TZDateTime.from(scheduledTime, tz.local);

    final int notifId = id.hashCode & 0x7fffffff;

    const androidDetails = AndroidNotificationDetails(
      'todo_channel',
      'Todo Notifications',
      channelDescription: 'Reminders for your todos',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      notifId,
      title,
      body,
      tzTime,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

      matchDateTimeComponents: null,
    );
  }

  /// cancel by id string (uses same hashing as schedule)
  static Future<void> cancelNotification(String id) async {
    final int notifId = id.hashCode & 0x7fffffff;
    await _plugin.cancel(notifId);
  }

  /// cancel all scheduled notifications
  static Future<void> cancelAll() => _plugin.cancelAll();
}
