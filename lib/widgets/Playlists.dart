import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_guide/objects/globals.dart';
import 'package:firebase_database/firebase_database.dart';
class Playlists extends StatefulWidget {
  @override
  _Playlists createState() => _Playlists();
}

class _Playlists extends State<Playlists> {
  List<Map<dynamic, dynamic>> playlistDB = [];
  List<List<String>> workoutPlaylist = [];
  _Playlists() {
    FirebaseDatabase.instance.reference().child("users/${globals.userKey}/playlists").once()
        .then((datasnapshot)
    {
      playlistDB.clear();
      Map<dynamic,dynamic> values = datasnapshot.value;
      values.forEach((key,value)
      {
        playlistDB.add(value);
      });
      setState(() {

      });
      workoutSeperator();
    }).catchError((onError) {
      print(onError.toString());
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: ListView.separated(
            itemCount: playlistDB.length,
            itemBuilder: (context,index){
              return Card(
              child: ExpansionTile(
                title: Text("${playlistDB[index]["name"]}"),
                    subtitle: Text("${playlistDB[index]["description"]}"),
                    children: <Widget> [
                      ListView.separated(itemBuilder: (BuildContext context, int indexNext) {
                    return ListTile(
                      title: Text(workoutPlaylist[index][indexNext]),
                    );
                  },
                      separatorBuilder: (context, index){return Divider();},
                      itemCount: workoutPlaylist[index].length,
                        shrinkWrap: true,
                      ),
                  ]
              ));

            },

            separatorBuilder: (context,index) {
              return Divider();
            },
           )
    );
  }

  void workoutSeperator() {

    for(int count = 0; count < playlistDB.length; count++)
      {
        workoutPlaylist.add(playlistDB[count]["workouts"].split(','));
        workoutPlaylist[count].removeLast();
      }
    setState(() {

    });
    print(workoutPlaylist);
  }
}