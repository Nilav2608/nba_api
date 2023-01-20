import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api/team.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});



  List<Team> teams = [];



  Future getData() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      final team =
          Team(abbreVation: eachTeam['abbreviation'], city: eachTeam['city']);
      teams.add(team);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return SafeArea(
      
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'NBA Teams list',
          ),
          backgroundColor: Colors.purple,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            //if done loding then show data
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListTile(
                          
                          title: Text(teams[index].abbreVation),
                          subtitle: Text(teams[index].city),
                        ),
                      ),
                    );
                  });
            }
            //if not show progress bar
            else {
              return const Center(
                child: CircularProgressIndicator(),
                
              );
            }
          },
        ),
      ),
    );
  }
}
