import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
import '../models/cart_model.dart';
import '../providers/auth_provider.dart';
import 'cart_screen.dart';
import 'login_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: const Color(0xfff4f4f4),
      appBar: AppBar(
        title: Text(
          'Xin chào, ${auth.currentUser?.fullName ?? ''}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          cart.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthProvider>().logout();
              context.read<CartModel>().removeAll();

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: catalogItems.length,
        itemBuilder: (context, index) {
          final item = catalogItems[index];

          return Consumer<CartModel>(
            builder: (context, cart, child) {
              final isAdded = cart.contains(item);

              return Card(
                margin: const EdgeInsets.only(bottom: 14),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple.withOpacity(0.12),
                    child: const Icon(Icons.shopping_bag),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${item.price} đ'),
                  trailing: ElevatedButton(
                    onPressed: isAdded
                        ? null
                        : () {
                      context.read<CartModel>().add(item);
                    },
                    child: Text(isAdded ? 'Đã thêm' : 'Thêm'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}