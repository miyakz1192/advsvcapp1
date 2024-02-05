import 'package:flutter/material.dart';
import 'advice_summary_model.dart';

class AdviceSummaryAll extends StatelessWidget {
  String summary;
  AdviceSummaryAll(this.summary);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('アドバイス概要'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  child :ListTile(
                    leading: Image.network('https://placehold.jp/50x50.png'),
                    title: Text('アドバイス概要'),
                    subtitle: Text(''),
                  ),
                ),
              ),
              Card(
                //Summary Area
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Text(summary,
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize)),
                  ),
                ),
            ]
        ),
      ),
    );
  }
}