import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/database/index.dart';
import 'package:test/model/populartv_model.dart';
import 'package:test/views/widget/card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({ Key? key }) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  late DatabaseHandler handler;
  late List<PV> popularTV = [];
  bool isloading=true;
  final _con = PopularTVController();
  void initState() {
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
          getfavoirte();
      setState(() {});
    });
    super.initState();
  }
  @override
  Future<void> getfavoirte() async{
    isloading=true;
    popularTV.clear();
    final  mid=await this.handler.retrieveUsers();
    popularTV.addAll(mid);
    setState(() {
      isloading=false;
    });
  }
  @override
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
                            image: popularTV[index].image == null
                                      ? ""
                                      : popularTV[index].image,
                                      title: popularTV[index].title==null
                                      ? ""
                                      : popularTV[index].title,
                                      description: popularTV[index].description==null
                                      ? ""
                                      : popularTV[index].description,
                            onpress: () {},
                            isfavorite: false);
                      }),
                ),
              ],
            ));
  }
}
