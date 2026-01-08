import 'package:brothers_stock/features/home/domain/product.dart';
import 'package:brothers_stock/core/utils/api_service.dart';

class ProductRepository {
  Future<List<Product>> getProducts() async {
    final response = await ApiService.get('products.php');
    if (response['status'] == 'success') {
      final List<dynamic> data = response['data'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception(response['message'] ?? 'Failed to load products');
    }
  }

  Future<Product> getProductById(int id) async {
    final response = await ApiService.get('products.php?id=$id');
    if (response['status'] == 'success') {
      return Product.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Product not found');
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await ApiService.post('products.php', product.toJson());
    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to add product');
    }
  }

  Future<void> updateProduct(Product product) async {
    final response = await ApiService.put('products.php', product.toJson());
    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to update product');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await ApiService.delete('products.php', id: id);
    if (response['status'] != 'success') {
      throw Exception(response['message'] ?? 'Failed to delete product');
    }
  }
}
