import 'package:carman/main.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

 @pragma('vm:entry-point')
 notificationTapBackground(NotificationResponse notificationResponse){
    if (notificationResponse.actionId=='confirm'){
     String? pL=notificationResponse.payload;
     navigatorKey.currentState?.pushNamed(AppRoutes.mostrarCarroDetalhes,arguments :int.parse(pL??''));
  }
  
  }
 

class NotificationController{
  static final FlutterLocalNotificationsPlugin plugin=FlutterLocalNotificationsPlugin();
  
  
  static Future init()async{
    await setupTimeZone();
    await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.
    requestNotificationsPermission();
    const AndroidInitializationSettings initializationSettingsAndroid =AndroidInitializationSettings('@mipmap/ic_launcher');
    const  InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
    await plugin.initialize(

      initializationSettings,
      onDidReceiveNotificationResponse: notificationTapBackground,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }
  static Future <void>  setupTimeZone()async{
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(await FlutterTimezone.getLocalTimezone()));
  }
   static Future <int> generateId()async{//função que gera um id para a notificação
    List <ActiveNotification>activenotifications=await plugin.getActiveNotifications();
    
    List<int?> notificationIds=activenotifications.map((notification)=>notification.id).toList();
    return notificationIds.isEmpty?0:notificationIds.last! +1;
  }
  //notificação simples
  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
                                                                    
  })async{
    int id =await generateId();//geração de id

    //detalhes da notificação
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'channel Id',
     'channel name',
     
     importance: Importance.max,
     priority: Priority.high,
     actions:   <AndroidNotificationAction>[
      AndroidNotificationAction('','Configuracoes',showsUserInterface: true)
     ],
     autoCancel: true
     );
    NotificationDetails notificationDetails=const NotificationDetails(android: androidDetails);
     await plugin.show(id,title , body, notificationDetails,payload: payload);
  }
  //notificação periódica
  static Future periodicNotificationWithActions({
    required String title,
    required String body,
    required String payload,
    required Duration duration,
    required String channelIdPeriodic,
    required String channelNamePeriodic,
    required String confirmButton,
    required String cancelButton,
  })async{
    final  id=await generateId();//gerando id 
    //detalhes da notificação 
    AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      channelIdPeriodic,
      channelNamePeriodic,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
      autoCancel: true,
      actions: <AndroidNotificationAction>[//botões da notificação
        AndroidNotificationAction('confirm', confirmButton,showsUserInterface: true),
        AndroidNotificationAction('close',cancelButton,cancelNotification: true)
      ],
    );
    NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    plugin.periodicallyShowWithDuration(
     id,
     title,
     body,
     payload: payload,
     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     duration,
     notificationDetails);

  }
  static Future<int> showScheduleNotificationWithActions({
    required String title,
    required String body,
    required String payload,
    required TimeOfDay timeOfDay,
    required String channelIdSchedule,
    required String channelNameSchedule,
    required DateTime date,
    required String confirmButton,
    required String cancelButton,
  })async{
    final  int id=await generateId();
    AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      channelIdSchedule, 
      channelNameSchedule,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      colorized: true,
      ongoing: true,
      category: AndroidNotificationCategory.event,
      autoCancel: true,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('confirm', confirmButton,showsUserInterface: true),
        AndroidNotificationAction('close',cancelButton,cancelNotification: true)
      ],
    );
    NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    await plugin.zonedSchedule(
      id,
     title, 
     body, 
     payload: payload,
     _nextInstanceOfChoosedTime(date, timeOfDay), 
    notificationDetails,
     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
    return id;
  }
  static Future showSchedulePeriodic({
    required String title,
    required String body,
    required String payload,
    required String channelIdSchedule,
    required String channelNameSchedule,
    required DateTime initialDate,
    required DateTimeComponents dateTimeComponents,
    required TimeOfDay timeOfDay,
    required String confirmButton,
    required String cancelButton,
  })async{
    final  int id=await generateId();
    AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      channelIdSchedule, 
      channelNameSchedule,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      colorized: true,
      ongoing: true,
      category: AndroidNotificationCategory.event,
      autoCancel: true,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('confirm', confirmButton,showsUserInterface: true),
        AndroidNotificationAction('close',cancelButton,cancelNotification: true)
      ],
    );
    NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    await plugin.zonedSchedule(
      id,
     title, 
     body, 
     payload: payload,
     _nextInstanceOfChoosedTime(initialDate, timeOfDay),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: dateTimeComponents,
    );
    return id;
    
  }
  static Future showSemestralPeriodic({
    required String title,
    required String body,
    required String payload,
    required String channelIdSchedule,
    required String channelNameSchedule,
    required DateTime initialDate,
    required TimeOfDay timeOfDay,
    required String confirmButton,
    required String cancelButton,
  })async{
    final  int id=await generateId();
    AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      channelIdSchedule, 
      channelNameSchedule,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      colorized: true,
      ongoing: true,
      category: AndroidNotificationCategory.event,
      autoCancel: true,
      priority: Priority.high,
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction('confirm', confirmButton,showsUserInterface: true),
        AndroidNotificationAction('close',cancelButton,cancelNotification: true)
      ],
    );
    NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    await plugin.zonedSchedule(
      id,
     title, 
     body, 
     payload: payload,
     _nextInstanceOfChoosedTimeSemestral(initialDate, timeOfDay),
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
    );
    return id;
    
  }

  static Future calcelAll()async{//função que cancela todas as notificações pendentes
    await plugin.cancelAll();

    

  }
  static Future cancelNotification(int id)async{//função que cancela uma notificação em específico
    await plugin.cancel(id);
  }

  static  tz.TZDateTime _nextInstanceOfChoosedTime(DateTime initialDate,TimeOfDay timeOfDay){
    final tz.TZDateTime choosedTime = tz.TZDateTime.from(initialDate,tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, choosedTime.year, choosedTime.month, choosedTime.day, timeOfDay.hour,timeOfDay.minute);
    if (scheduledDate.isBefore(choosedTime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
  static  tz.TZDateTime _nextInstanceOfChoosedTimeSemestral(DateTime initialDate,TimeOfDay timeOfDay){
    final tz.TZDateTime choosedTime = tz.TZDateTime.from(initialDate,tz.local);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, choosedTime.year, choosedTime.month, choosedTime.day, timeOfDay.hour,timeOfDay.minute);
    if (scheduledDate.isBefore(choosedTime)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate.add(const Duration(days: 182));
  }
  

}