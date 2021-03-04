import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app1/product.dart';
import 'package:http/http.dart';
import 'package:pretty_json/pretty_json.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future getProducts() async {
    String url = "https://6037c52d54350400177235f5.mockapi.io/product";
    Response res = await get(url);
    if(res.statusCode==200)
      return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: FutureBuilder(
            future: getProducts(),
            builder: (BuildContext context, s) {
              if (s.hasData)
                return GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: s.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return Product(pId: s.data[index]["productId"],);
                          }));
                        },
                        child: new GridTile(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)
                                ),
                                child: Image.network(
                                  s.data[index]["productImage"] == null
                                      ? "https://www.rawshorts.com/freeicons/wp-content/uploads/2017/01/orange_travelpictdinner_1484336833.png"
                                      : s.data[index]["productImage"],
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(s.data[index]["productName"]),
                              ),)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              else if (s.hasError) return Text("${s.error}");
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
