import 'package:flutter/material.dart';

void main() {
  runApp(BarayaFoodApp());
}

class BarayaFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Nasi Goreng',
      'quantity': 2,
      'image': 'https://via.placeholder.com/80.png?text=Nasi+Goreng',
    },
    {
      'name': 'Mie Ayam',
      'quantity': 1,
      'image': 'https://via.placeholder.com/80.png?text=Mie+Ayam',
    },
    {
      'name': 'Bakso',
      'quantity': 3,
      'image': 'https://via.placeholder.com/80.png?text=Bakso',
    },
  ];

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
           Center(
            child: Column(
              children: [
                Text(
                  'Keranjang Anda',
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
            SizedBox(height: 20),
            // List pesanan
           ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Text(
                    '${item['quantity']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(item['name']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                        item['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),

                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeItem(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            // Input alamat pengiriman
           TextField(
              decoration: InputDecoration(
                hintText: 'Alamat Pengiriman',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: null, // Untuk membuat TextField memperluas dirinya sendiri
            ),
            SizedBox(height: 20),
            // Tombol lakukan pembayaran
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk melakukan pembayaran
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Lakukan Pembayaran',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
