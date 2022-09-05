import 'package:flutter/material.dart';
import 'package:football3/constvalue.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../Provider/match.dart';
import '../../Matchdetails/matchdetails.dart';

class OnenextMatchPage extends StatefulWidget {
  const OnenextMatchPage({Key? key}) : super(key: key);

  @override
  State<OnenextMatchPage> createState() => _OnenextMatchPageState();
}

class _OnenextMatchPageState extends State<OnenextMatchPage> {
  DateTime dateTime = DateTime.now();
  LoadingState _loadingState = LoadingState.Initial;
  Future loaddata() async {
    setState(() {
      _loadingState = LoadingState.Loading;
    });
    try {
      await Provider.of<MatchProvider>(context, listen: false).getfixturematch(
          date: DateFormat("yyyy-MM-dd").format(
              DateTime(dateTime.year, dateTime.month, dateTime.day + 1)));
      setState(() {
        _loadingState = LoadingState.Loaded;
      });
    } catch (e) {
      setState(() {
        _loadingState = LoadingState.Error;
      });
    }
  }

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (_loadingState) {
      case LoadingState.Loading:
        child = const Center(
            child: CircularProgressIndicator(
          color: Colors.indigoAccent,
        ));
        break;
      case LoadingState.Loaded:
        child = matchlist();
        break;
      case LoadingState.Error:
        child = const Text("Error");
        break;

      case LoadingState.Initial:
        child = const Center(
            child: CircularProgressIndicator(
          color: Colors.indigoAccent,
        ));

        break;
    }
    return child;
  }

  Widget matchlist() {
    final livematch = Provider.of<MatchProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            var data = livematch.fixturematch[index];
            return Container(
              height: 50,
              margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[800]!.withOpacity(0.5),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                            fictureid: data.fixture!.id!,
                            team1: data.teams!.away['id'],
                            team2: data.teams!.home['id']),
                      ));
                },
                child: Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 70,
                              child: Text(
                                data.teams!.away['name'],
                                maxLines: 1,
                                textAlign: TextAlign.right,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.network(
                                data.teams!.away['logo'],
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              DateFormat('HH:mm').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      data.fixture!.timestamp! * 100000)),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              DateFormat('dd MMM, yyyy').format(
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      data.fixture!.timestamp! * 1000000)),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.network(
                              data.teams!.home['logo'],
                              height: 30,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                            width: 70,
                            child: Text(
                              data.teams!.home['name'],
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }, childCount: livematch.fixturematch.length),
        )
      ],
    );
  }
}
