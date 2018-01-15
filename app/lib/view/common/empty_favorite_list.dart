import 'package:flutter/material.dart';

class EmptyFavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 20.0),
              child: new Icon(Icons.favorite, size: 50.0, color: Colors.red,),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 12.0),
              child: new Text('No Favorites', style: new TextStyle(fontSize: 26.0, fontWeight: FontWeight.w500)),
            ),
            new Padding(
              padding: new EdgeInsets.only(bottom: 24.0),
              child: new Text('Favorited Heroes Will Appear Here', style: Theme.of(context).textTheme.title.apply(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}