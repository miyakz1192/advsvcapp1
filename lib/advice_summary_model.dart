import 'package:http/http.dart' as http;
import 'dart:convert';

/*
Thanks:
https://dev.classmethod.jp/articles/flutter-rest-api/
https://zenn.dev/iwaku/articles/2020-12-29-iwaku
https://pub.dev/packages/http
 */
class AdviceSummaryModel{
  late String summary = "no summary";

  Future<dynamic> getFromServer(DateTime day) async{
    String y = day.year.toString();
    String m = day.month.toString();
    String d = day.day.toString();
    print("INFO: [S] calling http get ${day}, ${y},${m},${d}");
    var response = await http.get(Uri.http(
        "192.168.122.54:8080",
        "summaries/${y}/${m}/${d}/"));
/*
    var response = await http.get(Uri.https(
        'www.googleapis.com',
        '/books/v1/volumes',
        {'q': '{Flutter}', 'maxResults': '40', 'langRestrict': 'ja'}));
*/
    print("INFO: [E] calling http get");
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse.toString());
    String temp = "";
    jsonResponse.forEach((element){
      if( element.containsKey("advice2summary") ){
        if( element["advice2summary"] != null ){
          temp += element["advice2summary"];
        }
      }
    });
    if( temp.isNotEmpty ){
      summary = temp;
    }else{
      summary = "no summary";
    }

    //print(jsonResponse[2]["advice2summary"]);
    return jsonResponse;
  }
}