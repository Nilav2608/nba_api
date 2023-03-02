import 'dart:convert';
import 'package:nba_api/shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nba_api/team.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  // shiMmer() {
    buildShimmerItems() => ListView.separated(
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return const ShimmerWidget();
      },
    );

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
          elevation: 0,
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
                            borderRadius: BorderRadius.circular(10)),
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
              return buildShimmerItems();
            }
          },
        ),
      ),
    );
  }
}
