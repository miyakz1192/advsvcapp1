import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'calendar_modal.dart';
import 'advice_summary_all.dart';
import 'dialog_detail.dart';
import 'advice_summary_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "おやもり",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        //thanks: https://qiita.com/najeira/items/dfa20d0104bd4457bc9a
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(), // iOS風
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      home: const MyHomePage(title: 'おやもり'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _summary = "アドバイスはありません。";
  AdviceSummaryModel summary_model = AdviceSummaryModel();

  late CalendarModal calm = CalendarModal(context);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _select_date(day){
    setState((){
        summary_model.getFromServer(calm.cal.selected_date);
        _summary = summary_model.summary;
      }
    );
  }

  void _refresh(){
    setState(() {
      print("INFO: called REFRESH!!!");
      //Flutter will detect what's variable was changed.
      //so we must to write "_summary = summary_model.summary;"
      _summary = summary_model.summary;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // 画面サイズを取得
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    List<Widget> myTiles = []; // 空のリストを作成


    // 動的にListTileを追加
    for (int i = 0; i < 10; i++) {
      myTiles.add(
        ListTile(
          leading: Image.network('https://placehold.jp/50x50.png'),
          title: Text('あれがあれして、こうしてね〜'),
          subtitle: Text('2024/1/19 13:00'),
          onTap: () {
            // ここにボタンを押した時に呼ばれるコードを書く
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DialogDetail()),
            );
          },
          //trailing: Icon(Icons.more_vert),
        ),
      );
    }

    String year = calm.cal.selected_date.year.toString();
    String month = calm.cal.selected_date.month.toString();
    String day = calm.cal.selected_date.day.toString();
    String date_str = year + "-" + month + "-" + day;
    Future<dynamic> run;
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title + " : " + date_str),
      ),
      //body: Center(
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              child :ListTile(
                leading: Image.network('https://placehold.jp/50x50.png'),
                title: Text('アドバイス概要'),
                subtitle: Text(''),
//              trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              //Summary Area
              child: Container(
                width: double.infinity,
                height: screenWidth * 0.3,
                color: Colors.white,
                child: GestureDetector(
                  child: Text("${_summary}",
                    //overflow: TextOverflow.ellipsis,
                    overflow: TextOverflow.fade,
                    // "style: Theme.of(context).textTheme.bodyLarge" can not be faded. Its reason is not clear....
                    style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
                  ),
                  onTap: () {
                    // ここにボタンを押した時に呼ばれるコードを書く
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AdviceSummaryAll(_summary)),
                    );
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Image.network('https://placehold.jp/50x50.png'),
                title: Text('会話詳細'),
                subtitle: Text(''),
                //trailing: Icon(Icons.more_vert),
              ),
            ),
            /*
            // https://qiita.com/kokogento/items/d467d25d29aa403182c4
            // this issues will show us to using silver and CustomScroll are better
            // but it is too difficult to me.
            // so for now, I will use SingleChildScrollView with ListView.builder
            // wth shrinkWrap: true,
            // TOBE: fix code to using silver
            */
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                print("************ IMAGE BUILDER CALLED *********************: ${index}");
                return myTiles[index];
              },
              itemCount: myTiles.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        onPressed: () => {
          calm.cal.call_back = _select_date,
          calm.showCalendarModal(_refresh),
          //TODO: FIXME: Async communication model for the future.
        },
        tooltip: 'カレンダー',
        child: const Icon(Icons.calendar_month_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class DecoratedText extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;

  const DecoratedText({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
          //style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize),
//          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.fade,
      ),
    );
  }
}