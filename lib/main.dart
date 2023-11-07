import 'package:flutter/material.dart';
import 'package:maincom/orders.dart';
import 'package:provider/provider.dart';
import 'product_overview_screen.dart';
import 'product_detail.dart';
import 'product_provider.dart';
import 'product.dart';
import 'cart.dart';
import 'cart_screen.dart';
import 'orders.dart';
import 'orders_screen.dart';
import 'user_product_item.dart';
import 'user_product.dart';
import 'edit_product_screen.dart';
import 'auth_screen.dart';
import 'auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Auth>(
            create: (context) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) {
              var _items = '';
              return Products('' as List<Product>, "", [] as String?);
            },
            update: (context, auth, previosProducts) => Products(
                auth.token as List<Product>,
                auth.userId!,
                (previosProducts == null ? [] : previosProducts.items)
                    as String?),
          ),
          ChangeNotifierProvider<Cart>(
            create: (context) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (context) => Orders('', "" as List<OrderItems>, []),
            update: (context, auth, previousOrders) => Orders(
              auth.token!,
              auth.userId as List<OrderItems>,
              previousOrders == null ? [] : previousOrders.orders,
            ),
          ),
        ],
        child: Consumer<Auth>(
          builder: (Context, auth, _) => MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              accentColor: Colors.grey,
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
