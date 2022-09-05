import 'package:flutter/material.dart';
import 'package:football3/Model/LiveMatch/livematch2.dart';
import '../Httpservice/league.dart';
import '../Httpservice/standing.dart';
import '../Model/All_League/all_league.dart';
import '../Model/LeagueFixture/leaguefixture.dart';
import '../Httpservice/fixturematch.dart';
import '../Httpservice/h2h.dart';
import '../Httpservice/livematch.dart';
import '../Httpservice/singlefixturematch.dart';
import '../Model/FutureMatch/futurematch.dart';
import '../Model/Headtohead/headtohead.dart';
import '../Model/Standings/standings.dart';

class MatchProvider extends ChangeNotifier {
  List<LiveMatch2> livematch = [];

  Future getlivematch() async {
    livematch = (await HttpLivematch().getlivematch())!;
    notifyListeners();
  }

  List<FutureMatch> fixturematch = [];

  Future getfixturematch({String? date}) async {
    fixturematch = (await HttpFixturmatch().getFutureMatch(date: date))!;
    
    notifyListeners();
  }


  Future getsinglematchinfo(int fixtureid) async {
    // singlematch = (await HttpSinglefixture().getsinglefixture(fixtureid))!;
    notifyListeners();
  }

  List<HeadtoHead> h2h = [];

  Future geth2h({int? teamid1, int? teamid2}) async {
    h2h = (await Httph2h().getheadtohead(teamid1: teamid1, teamid2: teamid2))!;
    notifyListeners();
  }






  List<Allleague> allleague = [];

  Future getallleague() async {
    allleague = (await HttpLeague().getallleague())!;
    notifyListeners();
  }

  List<Leaguefixture> leaguefixture = [];

  Future getleaguefixture({int? leagueid, int? season}) async {
    leaguefixture = (await HttpLeague()
        .getleaguefixture(leagueid: leagueid, season: season))!;
    notifyListeners();
  }

  List<Standings> standing = [];

  Future getstanding({int? leagueid, int? season}) async {
    standing =
        (await Httpstanding().getstanding(leagueid: leagueid, season: season))!;
    notifyListeners();
  }




  List<LiveMatch2>? custommatch = [];
  List<Allleague> customleague = [];

  Future getcustomlivematch(String? date, String status) async {
    var allleague = await HttpLeague().getallleague();
    custommatch = (await HttpLivematch().getlivematch())!;

    // var match = await HttpFixturmatch().getFutureMatch(date: date);
    customleague.clear();
    for (var i = 0; i < custommatch!.length; i++) {
      if (customleague.any(
              (element) => element.league!.id == custommatch![i].league!.id) ==
          true) {
        print("league allready added");
      } else {
        customleague.addAll(allleague!
            .where(
                (element) => element.league!.id == custommatch![i].league!.id)
            .toList());
      }
    }

    notifyListeners();
  }
}
