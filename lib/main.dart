import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // get remote config
  final RemoteConfig remoteConfig = await RemoteConfig.instance;
  remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
  
  // setup default values
  final defaults = <String, dynamic>{
    'welcome': 'Hello World!',
    };

    remoteConfig.setDefaults(<String, dynamic>{
      'primary_colour':0xFFFFFFFF
    });

  await remoteConfig.setDefaults(defaults);

  // get last config data
  final text = remoteConfig.getString('welcome');
 int primaryColour = await remoteConfig.getInt('primary_colour');
  // run app and use config data
  runApp(MyApp(text,primaryColour 
  ));

  // fetch and activate config data, data will be used in next restart
  await remoteConfig.fetch(expiration: Duration.zero);
  await remoteConfig.activateFetched();
 
  print('Welcome text is ' + remoteConfig.getString('welcome'));
}

class MyApp extends StatelessWidget {
  final _title = 'Firebase Config Demo';
  final String text;
  final int primaryColour;
  MyApp(this.text,this.primaryColour);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: _title,
        theme: ThemeData(
          //primaryColor: Color(0xFFFFFFFF),
          primaryColor: Color(primaryColour)
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          body: Center(
            child: Text(text),
          ),
        ));
  }
}
