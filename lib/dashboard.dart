import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  TextEditingController priceFieldCtrl = TextEditingController();

  createPriceDialog(BuildContext context, categoryName) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Amount spent on "+categoryName),
        content: TextField(
          controller: priceFieldCtrl,
          keyboardType: TextInputType.number
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child: Text('Submit'), onPressed: () {print('price submited');},
          )
        ],
      );
    });
  }


  Material categories(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () => createPriceDialog(context, heading),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //Text
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(heading,
                            style: TextStyle(
                                color: new Color(color), fontSize: 20.0)),
                      ),

                      //Icon
                      Material(
                        color: new Color(color),
                        borderRadius: BorderRadius.circular(24.0),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(icon, color: Colors.white, size: 30.0)),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Money Watcher', style: TextStyle(color: Colors.white))),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          categories(Icons.graphic_eq, "Fuel", 0xff7DB9C7),
          categories(Icons.graphic_eq, "Food", 0xffA3D9FF),
          categories(Icons.graphic_eq, "Coffee", 0xff7E6B8F),
          categories(Icons.graphic_eq, "Wedding", 0xffDA3E52)
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 130.0),
          StaggeredTile.extent(1, 130.0),
          StaggeredTile.extent(1, 130.0),
          StaggeredTile.extent(1, 130.0),
        ],
      ),
    );
  }
}

class MoneyStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/expenses.txt');
  }

  Future<String> readExpenses() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return contents;
    } catch (e) {
    }
  }
}