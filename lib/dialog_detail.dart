import 'package:flutter/material.dart';
import 'advice_summary_model.dart';

import 'package:flutter/material.dart';
import 'advice_summary_model.dart';

class DialogDetail extends StatelessWidget {
  String audio2text;
  String text2advice;
  DialogDetail(this.audio2text, this.text2advice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会話詳細'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Dialog Detail Area
              Container(
                width: double.infinity,
                child: Card(
                  child :ListTile(
                    leading: Image.network('https://placehold.jp/50x50.png'),
                    title: Text('会話詳細'),
                    subtitle: Text(''),
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Text(audio2text,
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize)),
                ),
              ),
              //Advice Detail Area
              Container(
                width: double.infinity,
                child: Card(
                  child :ListTile(
                    leading: Image.network('https://placehold.jp/50x50.png'),
                    title: Text('アドバイス詳細'),
                    subtitle: Text(''),
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Text(text2advice,
                      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize)),
                ),
              ),
            ]
        ),
      ),
    );
  }
}