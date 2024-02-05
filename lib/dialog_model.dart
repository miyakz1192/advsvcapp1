import 'package:http/http.dart' as http;
import 'dart:convert';

/*
Thanks:
https://dev.classmethod.jp/articles/flutter-rest-api/
https://zenn.dev/iwaku/articles/2020-12-29-iwaku
https://pub.dev/packages/http
 */
class DialogModel{
  late String audio2text = "no dialog";
  late String text2advice = "no advice";
  DialogModel(this.audio2text, this.text2advice);

  static Future<dynamic> getFromServer(DateTime day) async{
    String y = day.year.toString();
    String m = day.month.toString();
    String d = day.day.toString();
    print("INFO: [S] calling http get (dialog model) ${day}, ${y},${m},${d}");
    var response = await http.get(Uri.http(
        "192.168.122.54:8080",
        "dialogs/${y}/${m}/${d}/"));

    print("INFO: [E] calling http get (dialog model)");
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());

    List<DialogModel> res = [];
    String audio2text = "";
    String text2advice = "";
    jsonResponse.forEach((element){
      if( element.containsKey("audio2text") ){
        if( element["audio2text"] != null ){
          audio2text = element["audio2text"];
        }
      }
      if( element.containsKey("text2advice") ){
        if( element["text2advice"] != null ){
          text2advice = element["text2advice"];
        }
      }
      res.add(DialogModel(audio2text, text2advice));
    });
    //print(jsonResponse[2]["advice2summary"]);
    return res;
  }
}