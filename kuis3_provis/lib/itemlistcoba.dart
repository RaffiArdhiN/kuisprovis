import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Item {
  final String title;
  final String description;
  final int price;
  final int itemId;
  late String imageUrl; // Ubah definisi properti imageUrl

  Item({required this.title, required this.description, required this.price, required this.itemId, required this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      itemId: json['item_id'] ?? 0,
      imageUrl: '', // Kosongkan nilai awal untuk imageUrl
    );
  }
}


class ItemListPage extends StatelessWidget {
  final String token;

  const ItemListPage({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(token),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.description),
                  trailing: Text('\$${item.price.toString()}'),
                  leading: FutureBuilder<String>(
                    future: fetchItemImage(item.itemId, token),
                    builder: (context, imageSnapshot) {
                      if (imageSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (imageSnapshot.hasError) {
                        return Icon(Icons.error);
                      } else {
                        final imageUrl = imageSnapshot.data!;
                        return Image.network(imageUrl);
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Item>> fetchItems(String token) async {
    final response = await http.get(
      Uri.parse('http://146.190.109.66:8000/items/'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Item> items = [];
      for (var itemJson in data) {
        Item item = Item.fromJson(itemJson);
        items.add(item);
      }
      return items;
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<String> fetchItemImage(int itemId, String token) async {
    final response = await http.get(
      Uri.parse('http://146.190.109.66:8000/items_image/$itemId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final imageUrl = json.decode(response.body)['imageUrl'];
      return imageUrl;
    } else {
      // Jika gagal memuat gambar, return URL gambar default atau placeholder
      return 'idk';'https://example.com/default_image.jpg';
    }
  }
}
