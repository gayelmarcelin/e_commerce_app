import 'package:ecommerceapp/pages/product_details.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": "130",
      "price": "85"
    },
    {
      "name": "Blazer",
      "picture": "images/products/blazer2.jpeg",
      "old_price": "120",
      "price": "80"
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": "220",
      "price": "155"
    },
    {
      "name": "Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": "200",
      "price": "125"
    },
    {
      "name": "Hills",
      "picture": "images/products/hills1.jpeg",
      "old_price": "130",
      "price": "65"
    },
    {
      "name": "Hills",
      "picture": "images/products/hills2.jpeg",
      "old_price": "150",
      "price": "60"
    },
    {
      "name": "Pants",
      "picture": "images/products/pants1.jpg",
      "old_price": "100",
      "price": "20"
    },
    {
      "name": "Pants",
      "picture": "images/products/pants2.jpeg",
      "old_price": "100",
      "price": "20"
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "old_price": "150",
      "price": "35"
    },
    {
      "name": "Skt",
      "picture": "images/products/skt1.jpeg",
      "old_price": "90",
      "price": "35"
    },
    {
      "name": "Skt",
      "picture": "images/products/skt2.jpeg",
      "old_price": "80",
      "price": "15"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Single_Prod(
              prod_name: product_list[index]['name'],
              prod_picture: product_list[index]['picture'],
              prod_old_price: product_list[index]['old_price'],
              prod_price: product_list[index]['price'],
            ),
          );
        });
  }
}

class Single_Prod extends StatelessWidget {
  final prod_name;
  final prod_picture;
  final prod_old_price;
  final prod_price;

  Single_Prod(
      {this.prod_name,
      this.prod_picture,
      this.prod_old_price,
      this.prod_price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text('Hero'),
          child: Material(
            child: InkWell(
              onTap: () =>Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>
                      ProductDetails(
                        //we are passing the values of product details page
                        product_details_name: prod_name,
                        product_details_old_price: prod_old_price,
                        product_details_picture: prod_picture,
                        product_details_new_price: prod_price,
                  ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text(prod_name,style: TextStyle(
                        fontWeight: FontWeight.bold,fontSize: 16.0,
                      ),)),
                      Text(
                        "\$ $prod_price",
                        style: TextStyle(
                            color: Colors.red,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                child: Image.asset(
                  prod_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
