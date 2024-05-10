import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderStatusPage(),
    );
  }
}

class OrderStatusPage extends StatelessWidget {
  Future<void> _setOrderStatus(String endpoint) async {
    final userId = 1; // Ganti dengan userId yang sesuai
    final url = Uri.parse('http://146.190.109.66:8000/$endpoint/$userId');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      // Jika request berhasil
      print('Order status updated successfully');
    } else {
      // Jika request gagal
      print('Failed to update order status');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('set_status_harap_bayar');
              },
              child: Text('Set Harap Bayar'),
            ),
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('pembayaran');
              },
              child: Text('Bayar'),
            ),
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('set_status_penjual_terima');
              },
              child: Text('Set Penjual Terima'),
            ),
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('set_status_penjual_tolak');
              },
              child: Text('Set Penjual Tolak'),
            ),
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('set_status_diantar');
              },
              child: Text('Set Diantar'),
            ),
            ElevatedButton(
              onPressed: () {
                _setOrderStatus('set_status_diterima');
              },
              child: Text('Set Diterima'),
            ),
          ],
        ),
      ),
    );
  }
}
