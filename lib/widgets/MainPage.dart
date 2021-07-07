import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:fit_guide/widgets/Dictionary.dart';
import 'package:fit_guide/widgets/Playlists.dart';
import 'package:fit_guide/widgets/About.dart';
import 'package:fit_guide/tools/custom_fab_widget.dart';
import 'package:fit_guide/main.dart';
import 'package:fit_guide/objects/globals.dart';
import 'package:firebase_database/firebase_database.dart';
class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super (key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  final transitionType = ContainerTransitionType.fade;

  _MainPageState()
  {
    FirebaseDatabase.instance.reference().child("users").once().then((
        datasnapshot) {
      Map<dynamic, dynamic> values = datasnapshot.value;
      values.forEach((key, value) {
        if (value["email"] == globals.email) {
          globals.userKey = key;
        }
      });
        }).catchError((onError) {
  print("Something wrong with checking email");
  });
  }
  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }
  final List<Widget> _children = [
    Dictionary(),
   Playlists(),
    About(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SizedBox.expand(
        child:PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: _children,
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: "Home")));},
          child: Icon(Icons.water_damage,
          color: Colors.white,),
        ),
        backgroundColor: Colors.pink,
        title: Text('FIT-ionary',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Color(0xFF000000),
        unselectedItemColor:Colors.pink.withOpacity(0.5),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book),
            label: 'Dictionary',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.addchart_outlined),
              label: 'Playlists'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_rounded),
            label: 'Credits',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
      ),
      floatingActionButton: CustomFABWidget(transitionType: transitionType),
    );
  }
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
