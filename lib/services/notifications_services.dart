// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:schedule/src/models/schedule.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = 
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(iOS: initializationSettingsIOS, android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  displayNotification({required String title, required String body}) async {
    var androidPlatformChannelSpecifics = const 
    AndroidNotificationDetails(
      '1',
      'Agendamentos',
      channelDescription: 'Notificar agendamentos realizados',
      importance: Importance.max,
      priority: Priority.high,
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: "$title|$body|",
    );
  }

  scheduledNotificationDaily(int hour, int minutes, int remind, Schedule schedule) async {
    await flutterLocalNotificationsPlugin.
    zonedSchedule(
      schedule.id!,
      schedule.title,
      schedule.description,
      //Tempo até ser notificado
      _convertTime(hour, minutes - remind),
      const NotificationDetails(android: AndroidNotificationDetails('1', 'Agendamentos')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${schedule.title}|${schedule.description}|",
    );
  }

  scheduledNotificationWeekly(DateTime dateTime, int hour, int minutes, int remind, Schedule schedule) async {
    await flutterLocalNotificationsPlugin.
    zonedSchedule(
      schedule.id!,
      schedule.title,
      schedule.description,
      //Tempo até ser notificado
      tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, hour, minutes - remind, dateTime.weekday),
      const NotificationDetails(android: AndroidNotificationDetails('1', 'Agendamentos')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${schedule.title}|${schedule.description}|",
    );
  }

  scheduledNotificationMonthly(DateTime dateTime, int hour, int minutes, int remind, Schedule schedule) async {
    await flutterLocalNotificationsPlugin.
    zonedSchedule(
      schedule.id!,
      schedule.title,
      schedule.description,
      //Tempo até ser notificado
      tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, hour, minutes - remind, dateTime.day),
      const NotificationDetails(android: AndroidNotificationDetails('1', 'Agendamentos')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${schedule.title}|${schedule.description}|",
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.
    requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));

  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    return scheduleDate;
  }
  
}
