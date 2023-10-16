import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/database/index.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/views/widget/card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int length = 0;
  int page = 1;
  List<bool> isfavorite = [];
  late List<Populartv_Model> popularTV = [];
  final _con = PopularTVController();
  bool isloading = true, isexpanding = true, isend = false;
  late DatabaseHandler handler;
  Future<void> getfavoirte() async {
    setState(() {
      isfavorite.clear();
    });
    final mid = await this.handler.retrieveUsers();
    for (int i = 0; i < length; i++) {
      isfavorite.add(false);
      for (int j = 0; j < mid.length; j++) {
        if (popularTV[i].id == mid[j].id) {
          isfavorite[i] = true;
          break;
        }
      }
    }
    setState(() {
      isloading = false;
    });
  }

  Future<void> addfavoirte(
      int index, int id, String title, String description, String image) async {
    if (isfavorite[index]) {
      this.handler.deleteUser(id);
      setState(() {
        isfavorite[index] = false;
      });
    } else {
      this.handler.insertUser(
          [PV(id: id, title: title, description: description, image: image)]);
      setState(() {
        isfavorite[index] = true;
      });
    }
  }

  Future<void> getData({required String page}) async {
    if (!isend) {
      final mid = await _con.getPopularTv(page);
      if (mid.isEmpty) {
        setState(() {
          isend = true;
        });
      }
      if (isloading) {
        setState(() {
          popularTV.addAll(mid);
          getfavoirte();
        });
      } else {
        setState(() {
          setState(() {
            isexpanding = false;
          });
          popularTV.addAll(mid);
          getfavoirte();
          setState(() {
            isexpanding = true;
          });
        });
      }
      setState(() {
        length = popularTV.length;
      });
    }
  }

  @override
  void initState() {
    getData(page: page.toString());
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Container(
              height: MediaQuery.of(context).size.width * 0.5,
              color: Colors.transparent,
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            ),
          )
        : Container(
            color: Colors.grey,
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  if (isexpanding) {
                    getData(page: (page + 1).toString());
                    setState(() {
                      page += 1;
                    });
                  }
                }
                return true;
              },
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: popularTV.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return TVCard(
                              image: popularTV[index].poster_path == null
                                  ? ""
                                  : popularTV[index].poster_path!,
                              title: popularTV[index].name == null
                                  ? ""
                                  : popularTV[index].name!,
                              description: popularTV[index].overview == null
                                  ? ""
                                  : popularTV[index].overview!,
                              onpress: () {
                                addfavoirte(
                                    index,
                                    popularTV[index].id,
                                    popularTV[index].original_name.toString(),
                                    popularTV[index].overview!,
                                    popularTV[index].poster_path!);
                              },
                              isfavorite: isfavorite[index]);
                        }),
                  ),
                  Container(
                    height: isexpanding ? 0 : 100,
                    color: Colors.transparent,
                    child: Center(
                      child: new CircularProgressIndicator(),
                    ),
                  )
                ],
              ),
            ));
  }
}
