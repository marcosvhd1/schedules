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

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.
    requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> immediateNotification({required String title, required String body}) async {
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

  Future<void> scheduledNotification(DateTime dateTime, int hour, int minutes, Schedule schedule, {required String type}) async {
    await flutterLocalNotificationsPlugin.
    zonedSchedule(
      schedule.id,
      schedule.title,
      schedule.description,
      //TIPO DE NOTIFICAÇÃO
      type == 'Daily' ?
      //SE FOR DIÁRIA OU SÓ NO DIA, PEGA A 1 OPÇÃO                                                                                                                                                                   //SE NÃO VERIFICA SE É SEMANAL OU MENSAL 
      tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, hour, minutes - schedule.remind) : tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, hour, minutes - schedule.remind, type == 'Weekly' ? dateTime.weekday : dateTime.day),
      const NotificationDetails(android: AndroidNotificationDetails('1', 'Agendamentos')),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${schedule.title}|${schedule.description}|",
    );
  }

  Future<void> cancelScheduleNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllScheduleNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

}