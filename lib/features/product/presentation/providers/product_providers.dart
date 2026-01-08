import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brothers_stock/features/product/data/product_repository.dart';
import 'package:brothers_stock/features/home/domain/product.dart';

final productRepositoryProvider = Provider((ref) => ProductRepository());

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});
