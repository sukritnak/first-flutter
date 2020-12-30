// import 'package:firstFlutter/models/product.dart';
// ลองใช้ แบบไม่มี model dynamic

import 'package:firstFlutter/redux/appReducer.dart';
import 'package:firstFlutter/redux/product/productAction.dart';
import 'package:firstFlutter/redux/product/productReducer.dart';
import 'package:firstFlutter/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  _getData() async {
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(getProductAction(store));
  }

  @override
  void initState() {
    print('product no model');
    super.initState();

    Future.delayed(Duration.zero, () {
      _getData();
    });

    // พอใช้เป็น store มันเป็น async ต้องให้ build ก่อนค่อยมาเรียก โดยใช้ Future.delayed zero
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('สินค้า'),
        ),
        drawer: Menu(),
        body: StoreConnector<AppState, ProductState>(
            distinct: true,
            builder: (context, productState) {
              return productState.isLoading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(productState.course[index]['title']),
                          subtitle: Text(productState.course[index]['detail']),
                          trailing: Icon(Icons.arrow_right),
                          onTap: () {
                            Navigator.pushNamed(context, 'productstack/detail',
                                arguments: {
                                  'id': productState.course[index]['id'],
                                  'title': productState.course[index]['title']
                                });
                          },
                          leading: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(productState
                                        .course[index]['picture']))),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: productState.course.length);
            },
            converter: (store) => store.state.productState));
  }
}
