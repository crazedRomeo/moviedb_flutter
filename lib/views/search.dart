import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/views/widget/card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController filter = new TextEditingController(text: "");
  int page = 1;
  late List<Populartv_Model> popularTV = [];
  final _con = PopularTVController();
  bool isloading = false, isexpanding = true, isend = false;
  Future<void> getData({required String page, required String query}) async {
    if (!isend) {
      final mid = await _con.getPopularTvSearch(page, query);
      if (mid.isEmpty) {
        setState(() {
          isend = true;
        });
      }
      if (isloading) {
        popularTV.clear();
        setState(() {
          popularTV.addAll(mid);
          print(popularTV);
          isloading = false;
        });
      } else {
        setState(() {
          setState(() {
            isexpanding = false;
          });
          popularTV.addAll(mid);
          setState(() {
            isexpanding = true;
          });
        });
      }
    }
  }

  // void initState(){
  //    getData(page: page.toString(), query: filter.text);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: filter,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    setState(() {
                      isloading = true;
                      page = 1;
                      isend = false;
                    });
                    getData(page: page.toString(), query: filter.text);
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
          ),
          popularTV.isEmpty
              ? Container()
              : isloading
                  ? Container(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.transparent,
                        child: Center(
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Expanded(
                    child: Container(
                        color: Colors.grey,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              if (isexpanding) {
                                getData(
                                    page: (page + 1).toString(),
                                    query: filter.text);
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    itemCount: popularTV.length,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TVCard(
                                          image: popularTV[index].poster_path == null
                                          ? ""
                                          : popularTV[index].poster_path!,
                                          title: popularTV[index].name==null
                                          ? ""
                                          : popularTV[index].name!,
                                          description: popularTV[index].overview==null
                                          ? ""
                                          : popularTV[index].overview!,
                                          onpress: () {},
                                          isfavorite: false);
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
                        )),
                  )
        ],
      ),
    );
  }
}
