import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:locaapp/helpers.dart';
import 'package:locaapp/lang/app_locale.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('lang', 'ar');
  Locale locale =  Locale(prefs.getString('lang') , '');
  runApp(MyApp(locale));
}

class MyApp extends StatefulWidget {
  final Locale locale ;
  MyApp(this.locale);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: [
        // when Widget's alignment  changes
        // delegate wakil : give the permission to do changes depending on selected language
        AppLocale.delegate ,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],

      supportedLocales: [
        Locale('en' , ''),
        Locale('ar' , ''),
      ],
      locale: widget.locale,
      localeResolutionCallback: (currentLocale , supportedLocales){
        if (currentLocale.countryCode != null){
         for (Locale locale in supportedLocales){
           if (currentLocale.languageCode == locale.languageCode){
             return currentLocale ;
           }
         }
        }
        return supportedLocales.first;
        // That's enough for android but for ios we should add it to systme
      } , // to return the current local
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
             getTranslated(context, 'counter message')
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
