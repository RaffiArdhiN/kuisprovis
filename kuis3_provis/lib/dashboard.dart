import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kuis3_provis/mainstatus.dart';
import 'package:kuis3_provis/menu.dart';


// void main() {
//   runApp(BarayaFoodApp());
// }

class BarayaFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BarayaFood',
      debugShowCheckedModeBanner: false,
      home: Dashboard(token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImRlZmF1bHQiLCJleHAiOjE3MTU0MTYzMzh9.bZ89oEieBBSzeayv99RAEkfjUbYTOhorw5KtvVzkaHE'),
    );
  }
}

class Dashboard extends StatelessWidget {

  final String token;

  Dashboard({required this.token});

  final List<String> carouselImages = [
    'https://via.placeholder.com/300.png?text=Food+1',
    'https://via.placeholder.com/300.png?text=Food+2',
    'https://via.placeholder.com/300.png?text=Food+3',
  ];

  final List<Map<String, dynamic>> recommendedMenus = [
    {
      'name': 'Nasi Goreng Special',
      'image': 'https://via.placeholder.com/80.png?text=Nasi+Goreng',
    },
    {
      'name': 'Mie Ayam Bakso',
      'image': 'https://via.placeholder.com/80.png?text=Mie+Ayam',
    },
    {
      'name': 'Sate Padang',
      'image': 'https://via.placeholder.com/80.png?text=Sate+Padang',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarayaFood'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Arahkan ke halaman keranjang
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.person),
          //   onPressed: () {
          //     // Navigasi ke halaman profil
          //   },
          // ),
        ],
      ),
      body: ListView(

        children: [
          SizedBox(height: 20),

          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: carouselImages.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          // Spacer untuk memberikan jarak antara Carousel dan Kontainer baru
          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.restaurant_menu),
                  onPressed: () {
                    // Navigasi ke halaman menu
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => MenuPage()));
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.green,
                    width: 2.0,
                  ),
                ),
                child: IconButton(
                  icon: Icon(Icons.assignment),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Status()));
                    // Navigasi ke halaman status pesanan
                  },
                ),
              ),
            ],
          ),

          // Spacer untuk memberikan jarak antara Kontainer baru dan Daftar Toko
          SizedBox(height: 20),

          // Daftar Toko
          Text(
            'Rekomendasi Menu Hari Ini',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: recommendedMenus.map((menu) {
              return ListTile(
                leading: Image.network(
                  menu['image'],
                  width: 60,
                  height: 60,
                ),
                title: Text(menu['name']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}