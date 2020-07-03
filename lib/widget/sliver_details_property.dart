import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';

class SliverDetailProperty extends StatefulWidget {
  @override
  _SliverDetailProperty createState() => _SliverDetailProperty();
}

class _SliverDetailProperty extends State<SliverDetailProperty> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

          slivers: <Widget>[

            SliverPersistentHeader(

              pinned:true,

              floating: true,
              delegate: PagerHeader(
                mminExtent: 150,maxExtent: 250
              ),

            ),
            SliverToBoxAdapter(
              child: Text(";lgdfl;askkkkkkkkkkkkkkkkgdsafl;kdas;lkfal;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;;lgdfl;askkkkkkkkkkkkkkkkgdsafl;kdas;lkfal;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;;lgdfl;askkkkkkkkkkkkkkkkgdsafl;kdas;lkfal;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;;lgdfl;askkkkkkkkkkkkkkkkgdsafl;kdas;lkfal;gk;dlaskf;llllllllllllllllllllllllllllllla;ldskfal;sdkg;ladskgggggggga;lgdfl;askkkkkkkkkkkkkkkkgdsafl;kdas;lkfal;gk;dlaskf;lllllllllllllllllllllllllllllll",style: TextStyle(fontSize: 22),))

          ],

        )
    ;
  }

}

class PagerHeader implements SliverPersistentHeaderDelegate {

final double maxExtent ;
final double mminExtent ;

PagerHeader({@required this.maxExtent, this.mminExtent});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
   return Stack(
     fit: StackFit.expand,
     children: <Widget>[
       Image.network(

         'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',

         fit: BoxFit.cover,

       ),
       Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
             colors: [Colors.transparent , Colors.black45],
             stops: [0.5 , 1.0],
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             tileMode: TileMode.repeated,
           )
         ),
       ),
       Positioned(
         bottom: 16.0,left: 16.0 ,right: 16.0,
         child: Text("New House",style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.w600),),
       )
     ],
   );
  }

  @override
  // TODO: implement minExtent
  double get minExtent => mminExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true ;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;


}