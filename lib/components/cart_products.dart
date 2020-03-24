import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var products_on_the_cart = [
    {
      "name": "Pants",
      "picture": "images/products/pants2.jpeg",
      "price": "20",
      "size": "M",
      "color": "red",
      "quantity": "1"
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpg",
      "price": "35",
      "size": "M",
      "color": "blue",
      "quantity": "4"
    },
    {
      "name": "Dress",
      "picture": "images/products/dress2.jpeg",
      "old_price": "200",
      "price": "125",
      "size": "M",
      "color": "black",
      "quantity": "6"
    },
    {
      "name": "Hills",
      "picture": "images/products/hills1.jpeg",
      "old_price": "130",
      "price": "65",
      "size": "M",
      "color": "green",
      "quantity": "7"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
              cart_prod_name: products_on_the_cart[index]["name"],
              cart_prod_picture: products_on_the_cart[index]["picture"],
              cart_prod_price: products_on_the_cart[index]["price"],
              cart_prod_size: products_on_the_cart[index]["size"],
              cart_prod_color: products_on_the_cart[index]["color"],
              cart_prod_quantity: products_on_the_cart[index]["quantity"]);
        });
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_quantity;

  Single_cart_product(
      {this.cart_prod_name,
      this.cart_prod_picture,
      this.cart_prod_price,
      this.cart_prod_size,
      this.cart_prod_color,
      this.cart_prod_quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          cart_prod_picture,
          width: 80.0,
          height: 80.0,
        ),
        title: Text(cart_prod_name),
        subtitle: Column(
          children: <Widget>[
            Wrap(

              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(cart_prod_size,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    cart_prod_color,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "\$ $cart_prod_price",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                )),
          ],
        ),
        trailing: Column(
          children: <Widget>[
            Expanded(
                child: IconButton(
                    icon: Icon(Icons.arrow_drop_up), onPressed: () {})),
            Expanded(child: Text("$cart_prod_quantity")),
            Expanded(
                child: IconButton(
                    icon: Icon(Icons.arrow_drop_down), onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
