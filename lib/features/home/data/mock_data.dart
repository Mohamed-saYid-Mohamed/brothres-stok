import '../domain/product.dart';

final List<Product> mockProducts = [
  Product(
    id: '1',
    name: 'Brother Pro Laptop',
    description: 'High performance laptop for business and creative work.',
    price: 1299.99,
    imageUrl: 'https://placeholder.com/150',
    category: 'Electronics',
  ),
  Product(
    id: '2',
    name: 'Smart Business Watch',
    description: 'Stay connected and track your productivity.',
    price: 199.99,
    imageUrl: 'https://placeholder.com/150',
    category: 'Electronics',
  ),
  Product(
    id: '3',
    name: 'Premium Leather Bag',
    description: 'Executive leather bag for professionals.',
    price: 89.99,
    imageUrl: 'https://placeholder.com/150',
    category: 'Accessories',
  ),
  Product(
    id: '4',
    name: 'Wireless Noise Cancelling Headphones',
    description: 'Focus on your work with premium sound.',
    price: 249.99,
    imageUrl: 'https://placeholder.com/150',
    category: 'Electronics',
  ),
];

final List<String> categories = [
  'All',
  'Electronics',
  'Accessories',
  'Fashion',
  'Home',
];
