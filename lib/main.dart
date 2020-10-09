import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO 3 Map変数とList変数を追加する
  Map data;
  List userData;

  // TODO 1 APIを叩いてデータを取得する
  Future getData() async {
    http.Response response = await http.get('API_URL');
    // TODO 2 確認
    //  debugPrint(response.body);
    // TODO 4 デコードしたデータをdataに代入
    data = json.decode(response.body);
    // TODO 5 userDataに今回の場合Itemsのデータが必要なので取り出す
    setState(() {
      userData = data["Items"];
    });
    // TODO 6 確認
    debugPrint(userData.toString());
  }

  // TODO 2　初期化（ここで一度デバックを行う）
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Friends'),
        backgroundColor: Colors.green,
      ),
      // TODO 7 bodyでListView.builderを使用する
      body: ListView.builder(
        itemCount: userData == null ? 0 : userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: [
                Text('${userData[index]['video']['title']}'),
                Text(
                  '${userData[index]['video']['description']}',
                ),
                Text('${userData[index]['contributor']['user_id']}')
              ],
            ),
          );
        },
      ),
    );
  }
}
