import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  EmptyState(this.icon, {this.title, this.description});

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
              child: new Icon(
                icon,
                size: 200.0,
                color: Colors.grey.shade400,
              ),
            ),
            _buildTitle(context, title),
            _buildDescription(context, description),
          ],
        ),
      ),
    );
  }
}

Widget _buildDescription(BuildContext context, String description) {
  if (description == null || description.isEmpty){
    return new Container();
  }

  return new Padding(
              padding: new EdgeInsets.only(bottom: 24.0),
              child: new Text(description,
                  style: Theme
                      .of(context)
                      .textTheme
                      .title
                      .apply(color: Colors.grey)),
            );
}

Widget _buildTitle(BuildContext context, String title) {
  if (title == null || title.isEmpty){
    return new Container();
  }

  return new Padding(
              padding: new EdgeInsets.only(bottom: 12.0),
              child: new Text(title,
                  style: new TextStyle(
                      fontSize: 28.0, fontWeight: FontWeight.w500, color: Colors.grey.shade700)),
            );
}
