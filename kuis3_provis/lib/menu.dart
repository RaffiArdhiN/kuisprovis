import 'package:flutter/material.dart';

// void main() {
//   runApp(BarayaFoodApp());
// }

// class BarayaFoodApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MenuPage(),
//     );
//   }
// }

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // Map untuk melacak jumlah pesanan setiap menu
  final Map<String, int> _orderQuantities = {};

  final List<Map<String, String>> menuItems = [
    {
      'name': 'Nasi Goreng',
      'description': 'Nasi goreng dengan telur dan ayam.',
      'image': 'https://via.placeholder.com/80.png?text=Nasi+Goreng',
    },
    {
      'name': 'Mie Ayam',
      'description': 'Mie dengan potongan ayam dan sayuran.',
      'image': 'https://via.placeholder.com/80.png?text=Mie+Ayam',
    },
    {
      'name': 'Bakso',
      'description': 'Bakso dengan kuah kaldu dan mie.',
      'image': 'https://via.placeholder.com/80.png?text=Bakso',
    },
  ];

  void _increaseQuantity(String itemName) {
    setState(() {
      _orderQuantities[itemName] = (_orderQuantities[itemName] ?? 0) + 1;
    });
  }

  void _decreaseQuantity(String itemName) {
    setState(() {
      if (_orderQuantities[itemName]! > 0) {
        _orderQuantities[itemName] = (_orderQuantities[itemName] ?? 1) - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Arahkan ke halaman keranjang
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigasi ke halaman profil
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0), // Memberikan padding pada ListView
        children: [
          // Judul halaman
          Center(
            child: Column(
              children: [
                Text(
                  'Menu Kami',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // Garis horizontal
                Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          SizedBox(height: 20),  // Jarak antara judul dan daftar menu

          // Daftar menu
          ...menuItems.map((menu) {
            final itemName = menu['name']!;
            final quantity = _orderQuantities[itemName] ?? 0; // Jika belum ada, set 0

            return ListTile(
              leading: Image.network(
                menu['image']!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              title: Text(menu['name']!),
              subtitle: Text(menu['description']!),
              trailing: quantity == 0
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      _increaseQuantity(itemName);
                    },
                    child: Text(
                      'Tambahkan',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.green),
                        onPressed: () {
                          _decreaseQuantity(itemName);
                        },
                      ),
                      Text('$quantity', style: TextStyle(color: Colors.green)),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.green),
                        onPressed: () {
                          _increaseQuantity(itemName);
                        },
                      ),
                    ],
                  ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
