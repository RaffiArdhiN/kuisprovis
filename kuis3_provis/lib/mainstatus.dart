import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Status',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => OrderStatusCubit(),
        child: OrderStatusPage(),
      ),
    );
  }
}

enum OrderStatus { HarapBayar, MenungguKonfirmasi, Dikirim, Diterima }

class OrderStatusCubit extends Cubit<OrderStatus> {
  OrderStatusCubit() : super(OrderStatus.HarapBayar);

  Future<void> _setOrderStatus(String endpoint) async {
    final userId = 1; // Ganti dengan userId yang sesuai
    final url = Uri.parse('http://146.190.109.66:8000/$endpoint/$userId');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer <token>',
      },
      body: jsonEncode(<String, dynamic>{
        // Ganti dengan data tambahan dalam badan permintaan jika diperlukan
      }),
    );
    if (response.statusCode == 200) {
      // Jika request berhasil
      print('Order status updated successfully');
    } else {
      // Jika request gagal
      print('Failed to update order status');
    }
  }

  void bayar() async {
    await _setOrderStatus('set_status_harap_bayar');
    emit(OrderStatus.MenungguKonfirmasi);
  }

  void terimaPesanan() async {
    await _setOrderStatus('set_status_penjual_terima');
    emit(OrderStatus.Dikirim);
  }

  void terimaBarang() async {
    await _setOrderStatus('set_status_diterima');
    emit(OrderStatus.Diterima);
  }
}

class OrderStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Status'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<OrderStatusCubit, OrderStatus>(
              builder: (context, state) {
                return Text(
                  _getStatusText(state),
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
            SizedBox(height: 20),
            BlocBuilder<OrderStatusCubit, OrderStatus>(
              builder: (context, state) {
                if (state == OrderStatus.HarapBayar) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<OrderStatusCubit>(context).bayar();
                    },
                    child: Text('Bayar'),
                  );
                } else if (state == OrderStatus.MenungguKonfirmasi) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<OrderStatusCubit>(context).terimaPesanan();
                    },
                    child: Text('Terima Pesanan'),
                  );
                } else if (state == OrderStatus.Dikirim) {
                  return ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<OrderStatusCubit>(context).terimaBarang();
                    },
                    child: Text('Terima Barang'),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.HarapBayar:
        return 'Harap Melakukan Pembayaran';
      case OrderStatus.MenungguKonfirmasi:
        return 'Menunggu Konfirmasi Penjual';
      case OrderStatus.Dikirim:
        return 'Pesanan Sedang Dikirim';
      case OrderStatus.Diterima:
        return 'Pesanan Anda Sudah Sampai';
      default:
        return '';
    }
  }
}
