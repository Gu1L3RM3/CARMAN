import 'package:carman/models/providers.dart';
import 'package:carman/utils/theme_data.dart';
import 'package:carman/pages/home_page.dart';
import 'package:carman/utils/app_routes.dart';
import 'package:carman/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
final navigatorKey = GlobalKey<NavigatorState>();


String? initialRoute;
String? payload;

Future<void> main(List<String> args) async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.init();
  
  final  NotificationAppLaunchDetails? details=await NotificationController.plugin.getNotificationAppLaunchDetails();
  
  if (details?.didNotificationLaunchApp ?? false){
    //initialRoute=AppRoutes.adicionarCarro;
    if(details?.notificationResponse?.actionId=="confirm"){
    payload=details?.notificationResponse?.payload;
    navigatorKey.currentState?.pushReplacementNamed(AppRoutes.mostrarCarroDetalhes,arguments: payload);}
  }
  runApp(CustomProvider.multiprovider(
    carman: const CarmanApp(),
  ));
}



class CarmanApp extends StatelessWidget {
  const CarmanApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);//fixa na vertical
    
    return   MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales:const  [
        Locale('pt','BR'),
      ],
        title:'Carman',
        navigatorKey: navigatorKey,
        
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home:  const HomePage(),
        routes: AppRoutes.routes
      );
    
  }
}

