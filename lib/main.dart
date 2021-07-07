import 'package:flutter/material.dart';
import 'package:fit_guide/widgets/SignUpPage.dart';
import 'package:fit_guide/widgets/loginPage.dart';
void main() {
  runApp(FitGuide());
}

class FitGuide extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Guide',
      initialRoute: '/',
      routes: {
        '/' : (context) => MyHomePage(title: "HomePage"),
        '/second' : (context) => SignUpPage(),
        '/third' : (context) => loginPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightBlue,
        canvasColor: Colors.black,
        accentColor: Colors.pink,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:
        new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
            new Container(
              padding: EdgeInsets.all(0.0),
              alignment: Alignment.center,
              child:
              new FlutterLogo(
                size: 115.0,
              ),
            ),
          new Padding(padding: EdgeInsets.all(70.0)),
          new Container(
          padding: EdgeInsets.fromLTRB(1.0, 6.0, 1.0, 6.0),
          width: 250,
          height: 100,
          child:
           new ElevatedButton(
           onPressed:(){
             Navigator.pushNamed(context, '/second');
           },
            child:  const Text("Sign Up"),
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical:20),
              shape:new RoundedRectangleBorder( borderRadius: new BorderRadius.circular(30)),
          ),
          ),
        ),
            new Container(
              padding:EdgeInsets.all(5.0),
              width: 250,
              height: 100,
              child:
              new ElevatedButton(onPressed: (){
                Navigator.pushNamed(context, '/third');
              },
                  child: const Text("Login"),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30)),
              ),
              ),
            )


      ],
    ),
    );
  }
}
