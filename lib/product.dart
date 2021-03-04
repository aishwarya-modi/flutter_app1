import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product extends StatefulWidget{
  final String pId;

  const Product({Key key, this.pId}) : super(key: key);

  _ProductState createState()=> _ProductState();
}

class _ProductState extends State<Product>{

  String url, name, cost, brand, categ, color, material, avail, lDate, summ;
  bool isLoaded = false;

  @override
  void initState() {
    getProductDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoaded)
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                      ),
                      child: Image.network(url, height: 300, width: 300,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                      Expanded(child: Text("Rs. $cost", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("by $brand", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                      Expanded(child: Text("in $categ", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Color: $color", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                      Expanded(child: Text("Material $material", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Available in $avail", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                      Expanded(child: Text("Launched on $lDate", style: TextStyle(fontSize: 16, color: Colors.grey),)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("About: ", style: TextStyle(fontSize: 14, color: Colors.grey),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(summ, ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<void> getProductDetails() async {
    String url1 = "https://6037c52d54350400177235f5.mockapi.io/product/${widget.pId}";
    Response res = await get(url1);
    if(res.statusCode==200){
      var data = jsonDecode(res.body);
      url = data["productImage"];
      name = data["productName"];
      cost = data["productCost"];
      brand = data["productBrand"];
      categ = data["productCategory"];
      color = data["productColor"];
      material = data["productMaterial"];
      avail = data["productAvailability"];
      lDate = data["productLaunchDate"];
      summ = data["productSummary"];
      setState(() {
        isLoaded = true;
      });
    }
  }
}