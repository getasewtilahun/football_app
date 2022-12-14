import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:football3/constvalue.dart';
import 'package:provider/provider.dart';

import '../../Provider/match.dart';
import 'Tab/headtohead.dart';

class DetailsPage extends StatefulWidget {
  final int fictureid;
  final int team1;
  final int team2;
  const DetailsPage(
      {Key? key,
      required this.fictureid,
      required this.team1,
      required this.team2})
      : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  LoadingState _loadingState = LoadingState.Initial;

  Future loaddata() async {
    setState(() {
      _loadingState = LoadingState.Loading;
    });
    try {
      await Provider.of<MatchProvider>(context, listen: false)
          .getsinglematchinfo(widget.fictureid);
      await Provider.of<MatchProvider>(context, listen: false)
          .geth2h(teamid1: widget.team1, teamid2: widget.team2);
      Provider.of<MatchProvider>(context, listen: false);
      setState(() {
        _loadingState = LoadingState.Loaded;
      });
    } catch (e) {
      setState(() {
        _loadingState = LoadingState.Error;
      });
    }
  }

  List<Tab> tablist = [
    const Tab(text: "Head To Head"),
    const Tab(text: "TimeLine"),
    const Tab(text: "Statistics"),
    const Tab(text: "Formation"),
    const Tab(text: "Team"),
  ];

  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Column(children: [
       header(),
       const HeadtoHeadPage(),

     ],),
   );}

  Widget header() {
    final data = Provider.of<MatchProvider>(context).singlematch.first;
    return Container(
      padding: const EdgeInsets.all(10),
      height: 190.h,
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[800]!.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red[200]!),
                borderRadius: BorderRadius.circular(50)),
            child: Text(
              data.fixture!.status!.long!,
              style: TextStyle(fontSize: 10.sp, color: Colors.white),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: 10.h),
                  Container(
                      width: 80.w,
                      child: Text(
                        data.teams!.away['name'],
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(color: Colors.white),
                      )),
                ],
              ),
              Column(
                children: [
                  Text(
                    "${data.goals!.away ?? 0} : ${data.goals!.home ?? 0}",
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "${data.fixture!.status!.elapsed ?? 0}",
                    style: const TextStyle(color: Colors.green),
                  )
                ],
              ),
             ],
          ),

        ],
      ),
    );
  }


}
