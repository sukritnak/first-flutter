import 'package:firstFlutter/redux/appReducer.dart';
import 'package:firstFlutter/redux/product/productReducer.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

@immutable
class GetProductAction {
  final ProductState productState;
  GetProductAction(this.productState);
}

//action

getProductAction(Store<AppState> store) async {
  try {
// ไม่ว่ายังไงก้ตามให้ loading สักหน่อย โดยดังนี้ ไม่ต้องใส่ก้ได้อันนี้หลอก user
    store.dispatch(GetProductAction(ProductState(isLoading: true)));

    var url = 'https://api.codingthailand.com/api/course';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> product = convert.jsonDecode(response.body);
      // setState(() {
      //   course = product['data'];
      //   isLoading = false;
      // });
      store.dispatch(GetProductAction(
          ProductState(course: product['data'], isLoading: false)));
    } else {
      // setState(() {
      //   isLoading = false;
      // });
      store.dispatch(
          GetProductAction(ProductState(course: [], isLoading: false)));
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    // setState(() {
    //   isLoading = false;
    // });
    store
        .dispatch(GetProductAction(ProductState(course: [], isLoading: false)));
  }
}
