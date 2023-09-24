import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Productlist(),
    );
  }
}

class Productlist extends StatefulWidget{
  const Productlist({super.key});

  @override
  State<StatefulWidget> createState() => ProductlistState();

}

class ProductlistState extends State<StatefulWidget> {
  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 15),
    Product(name: "Product 3", price: 20),
    Product(name: "Product 4", price: 20),
    Product(name: "Product 5", price: 20),
    Product(name: "Product 6", price: 20),
    Product(name: "Product 7", price: 20),
    Product(name: "Product 8", price: 20),
    Product(name: "Product 9", price: 20),
    Product(name: "Product 10", price: 20),
    Product(name: "Product 11", price: 20),
    Product(name: "Product 12", price: 20),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text('Product List',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context,index){
          return Producttile(product : products[index]);
        },),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){
         Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => Cartview(products: products)
            )
         );

        },
        child:Icon(Icons.shopping_cart_outlined) ,
      ),
    );
  }
}

class Producttile extends StatefulWidget{
  final Product product;
  Producttile({required this.product});

  @override
  State<Producttile> createState() => _ProducttileState();
}

class _ProducttileState extends State<Producttile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(

      title: Text(widget.product.name),
      subtitle: Text('Tk ${widget.product.price}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Text('Quatiy: ${widget.product.quantity}',style: TextStyle(fontSize: 12),),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 4,
              ),
                onPressed:(){
                setState(() {
                  widget.product.quantity++;
                  if (widget.product.quantity == 5){
                    showDialog(context: context, builder: (context){
                     return AlertDialog(
                       title: Text('Congratulations! You\'ve bought 5 ${widget.product.name
                       },'),
                      actions: [
                        TextButton(onPressed: (){
                         Navigator.of(context).pop();
                        }, child: Text('ok'))
                      ],
                     );
                    }) ;
                  }
                });
            }, child: Text('Buy Now') ),
          )
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int quantity =0 ;

  Product({required this.name, required this.price});
}

class Cartview extends StatelessWidget{
  final List<Product> products;
  Cartview({super.key, required this.products}) ;
  @override
  Widget build(BuildContext context) {
    int totalQuantity = products.fold(0, (sum, product) => sum + product.quantity);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Cart',style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Total Products ${totalQuantity}')
          ],
        ),
      ),
    ) ;
  }

}