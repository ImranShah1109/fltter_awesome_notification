import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

void main() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Channel',
        channelDescription: 'Notification for basic channel test'
      )
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(!isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  triggerNotification(){
    AwesomeNotifications()
      .createNotification(
        content: NotificationContent(
            id: 9, 
            channelKey: 'basic_channel',
            title: 'Simple Notificaton',
            body: 'This a notification by app'
          )
      );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body:Center(
              child: ElevatedButton(
              onPressed: triggerNotification, 
              child: const Text('Trigger Notification')
            )
            ),
      );
  }
}
