import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TVCard extends StatefulWidget {
  final VoidCallback onpress;
  final String image, title, description;
  final bool isfavorite;
  const TVCard(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.onpress,
      required this.isfavorite})
      : super(key: key);

  @override
  State<TVCard> createState() => _TVCardState();
}

class _TVCardState extends State<TVCard> {
  final imagepath = dotenv.env["IMAGE_PATH"];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onpress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height:200,
            color: Colors.white,
              child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:imagepath!+widget.image,
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.fill,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/images/profile.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(onPressed: widget.onpress, icon: Icon(Icons.favorite,color:widget.isfavorite?Colors.yellow:Colors.grey)),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  child: Column(
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      Text(
                        widget.description,
                        overflow:TextOverflow.ellipsis,
                        maxLines: 8,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          )),
        ));
  }
}
