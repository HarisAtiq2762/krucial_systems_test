import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:krucial_systems/models/Store.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
class HomeScreenCard extends StatelessWidget {
  Store store;
  HomeScreenCard({Key key,@required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.12,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              // width: 200,
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(store.img)
                )
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(store.category,style: TextStyle(color: Colors.black.withOpacity(1),fontWeight: FontWeight.w500,fontSize: 12),),
              Text(store.name,style: TextStyle(color: Colors.black.withOpacity(1),fontWeight: FontWeight.bold,fontSize: 20),),
              Text(store.address,style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold,fontSize: 12)),
              Container(
                width: MediaQuery.of(context).size.width*0.739,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SmoothStarRating(
                          starCount: 5,
                          isReadOnly: true,
                          color: Colors.orange.shade300,
                          size: 12.0,
                          rating: double.parse(store.rating),
                          filledIconData: FontAwesomeIcons.solidStar,
                          defaultIconData: FontAwesomeIcons.star,
                          borderColor: Colors.orange.shade300,
                        ),
                        SizedBox(width: 10,),
                        Text(store.rating,style: TextStyle(color: Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold,fontSize: 13)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.0,8.0,0.0),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.share,size: 13,),
                          SizedBox(width: 10,),
                          FaIcon(FontAwesomeIcons.heart,size: 13,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
