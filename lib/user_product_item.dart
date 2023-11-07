import 'package:flutter/material.dart';
import 'edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'product_grid.dart';
import 'product_detail.dart';
import 'product_provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageurl;
  final String? id;

  UserProductItem(
    this.title,
    this.imageurl,
    this.id,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: id,
              );
            },
            color: Theme.of(context).primaryColor,
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              Provider.of<Products>(context, listen: false).deleteProduct(id!)
                  as String;
            },
            color: Theme.of(context).errorColor,
            icon: Icon(Icons.delete),
          ),
        ]),
      ),
    );
  }
}
