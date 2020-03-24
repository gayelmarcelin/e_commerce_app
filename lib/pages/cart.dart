import 'package:ecommerceapp/components/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.red,
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Cart_products(),
      bottomNavigationBar: Container(
        color: Colors.white,
          child: Row(
            children: <Widget>[
              Expanded(child: ListTile(
                title: Text("Total"),
                subtitle: Text("\$ 230"),
              ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(onPressed: (){},
              child: Text("Check out",style: TextStyle(color: Colors.white),),
                color: Colors.red,
              ),
              ),
            ],
          ),
      ),
    );
  }
}
