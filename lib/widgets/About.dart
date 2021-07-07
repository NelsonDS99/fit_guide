import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class About extends StatefulWidget {
  @override
  _About createState() => _About();
}

class _About extends State<About> {
  void _showProfile() async {
    final url = "https://github.com/NelsonDS99";
    if(await canLaunch(url))
      {
        await launch(url);
      }
    else {
      print("Failed to open link");
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ListTile(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pinimg.com/originals/48/e0/73/48e07378e01dd719c060c1f2f2b5cb00.png"),
                backgroundColor: Colors.white,
              ),
              title: Text('FIT-ionary',
              style: TextStyle(color: Colors.white),),
              subtitle: Text(
                'A guide to your fitness workouts',
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){_showProfile();},
            ),
            Divider(
              color: Colors.white10,
              thickness: 1.0,
              height: 1.0,
            ),
            ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.pink,
              ),
              title: Text('Rate our app',
              style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created by Nelson Scott',
                  style: TextStyle(color: Colors.white),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}