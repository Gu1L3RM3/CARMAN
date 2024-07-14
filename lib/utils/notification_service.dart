import 'package:carman/main.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

 @pragma('vm:entry-point')
 notificationTapBackground(NotificationResponse notificationResponse){
    if (notificationResponse.actionId=='config'){
    navigatorKey.currentState?.pushNamed(AppRoutes.adicionarCarro,arguments: notificationResponse.payload);
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
    required int seconds,
  })async{
    final  id=await generateId();//gerando id 

    //detalhes da notificação 
    const AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      'channel Id periodic', 
      'channel Name periodic',

      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.max,
      autoCancel: true,
      actions: <AndroidNotificationAction>[//botões da notificação
        AndroidNotificationAction('confirm', 'Confirmar',showsUserInterface: true),
        AndroidNotificationAction('close','fechar',cancelNotification: true)
      ],
    );
    const NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    plugin.periodicallyShow(
     id,
     title,
     body,
     payload: payload,
     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
     RepeatInterval.everyMinute,
     notificationDetails);

  }
  static Future showScheduleNotificationWithActions({
    required String title,
    required String body,
    required String payload,
    required int seconds
  })async{
    final  int id=await generateId();
    final date=DateTime.now().add(Duration(seconds: seconds));
    const AndroidNotificationDetails androidDetails=
    AndroidNotificationDetails(
      'channel Id schedule', 
      'channel Name schedule',
      
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
        AndroidNotificationAction('edit', 'Editar',showsUserInterface: true),
        AndroidNotificationAction('close','fechar',cancelNotification: true)
      ],
    );
    const NotificationDetails notificationDetails=NotificationDetails(android: androidDetails);
    await plugin.zonedSchedule(
      id,
     title, 
     body, 
     payload: payload,
     tz.TZDateTime.from(date,tz.local), 
    notificationDetails,
     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future calcelAll()async{//função que cancela todas as notificações pendentes
    await plugin.cancelAll();
    

  }
  static Future cancelNotification(int id)async{//função que cancela uma notificação em específico
    await plugin.cancel(id);
  }

}