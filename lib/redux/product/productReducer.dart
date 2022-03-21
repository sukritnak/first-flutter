import 'package:firstFlutter/redux/product/productAction.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

// reducer หน้าที่รับ state มา อัพเดทและ return ออก
@immutable
class ProductState extends Equatable {
  final List<dynamic> course;
  final bool isLoading;

  ProductState({this.course = const [], this.isLoading = true});

  ProductState copyWith({List<dynamic> course, bool isLoading}) {
    return ProductState(
        course: course ?? this.course, isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [course, isLoading];
}

ProductState productReducer(ProductState state, dynamic action) {
  if (action is GetProductAction) {
    return state.copyWith(
        course: action.productState.course,
        isLoading: action.productState.isLoading);
  }
  return state;
}
