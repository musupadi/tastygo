import 'package:flutter/material.dart';
import 'package:tastygo/Constant/Colors.dart';

import '../Model/Ascendant.dart';
import 'InvoicePage.dart';

class Detailscanner extends StatefulWidget {
  const Detailscanner({super.key});

  @override
  State<Detailscanner> createState() => _DetailscannerState();
}

class _DetailscannerState extends State<Detailscanner> {
  // List to store selected items with quantities
  final List<Map<String, dynamic>> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Restoran',style: TextStyle(color: Colors.white),),
        backgroundColor: PrimaryColors(),
        iconTheme: const IconThemeData(color: Colors.white), // Set the back icon color to white
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Stack(
              children: [
                Image.network(
                  'https://images.unsplash.com/photo-1528605248644-14dd04022da1?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDE0fHxjYWZlfGVufDB8fHx8MTYyNDAxNzU2MA&ixlib=rb-1.2.1&q=80&w=800',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Text(
                      'Warung Makan Sederhana',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Restaurant Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.teal),
                          SizedBox(width: 8.0),
                          Text(
                            'Jl. Merdeka No. 1, Jakarta',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.orange),
                          SizedBox(width: 4.0),
                          Text(
                            '4.5',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),

                  // Restaurant Description
                  const Text(
                    'Restoran ini menyediakan berbagai macam makanan dan minuman khas Nusantara dengan suasana yang nyaman dan harga terjangkau.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 16.0),

                  // Menu Section Title
                  const Text(
                    'Menu Makanan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),

            // Menu List
            SizedBox(
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16.0),
                children: [
                  menuCard(
                    'https://assets.unileversolutions.com/recipes-v2/242794.jpg',
                    'Nasi Goreng',
                    '25,000',
                  ),
                  menuCard(
                    'https://images.unsplash.com/photo-1551183053-bf91a1d81141?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDN8fGNoaWNrZW4lMjBkaXNoZXN8ZW58MHx8fHwxNjI0MDE3NTYw&ixlib=rb-1.2.1&q=80&w=200',
                    'Ayam Bakar',
                    '30,000',
                  ),
                  menuCard(
                    'https://images.unsplash.com/photo-1543353071-873f17a7a088?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDR8fGRyaW5rc3xlbnwwfHx8fDE2MjQwMTc1NjA&ixlib=rb-1.2.1&q=80&w=200',
                    'Es Teh Manis',
                    '8,000',
                  ),
                  menuCard(
                    'https://www.sidechef.com/recipe/a6454a57-23b7-4884-b6fa-b4a73b28d7fe.jpg?d=1408x1120',
                    'Pisang Goreng',
                    '15,000',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Action Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Show selected items in a dialog
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Pesanan Anda'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: selectedItems.map((item) {
                            return ListTile(
                              title: Text(item['name']),
                              subtitle: Text(
                                  'Rp ${item['price']} x ${item['quantity']}'),
                            );
                          }).toList(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Tutup'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              try {
                                final totalPrice = selectedItems.fold<int>(
                                  0,
                                      (sum, item) => sum + (parsePrice(item['price']) * item['quantity']).toInt(),
                                );


                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InvoicePage(
                                      selectedItems: selectedItems,
                                      totalPrice: totalPrice,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Terjadi kesalahan: ${e.toString()}')),
                                );
                              }
                            },


                            child: const Text('Konfirmasi Pesanan'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimaryColors(),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Menu Card Widget
  Widget menuCard(String imageUrl, String name, String price) {
    return StatefulBuilder(
        builder: (context, setState) {
      final itemIndex =
      selectedItems.indexWhere((item) => item['name'] == name);
      final quantity = itemIndex >= 0 ? selectedItems[itemIndex]['quantity'] : 0;

      return Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        // Menu Image
        ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          imageUrl,
          height: 150,
          width: 200,
          fit: BoxFit.cover,
        ),
      ),
    const SizedBox(height: 8.0),

    // Menu Name
    Text(
    name,
    style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
    ),
    ),
    const SizedBox(height: 4.0),

    // Menu Price
    Text(
    'Rp $price',
    style: const TextStyle(
    fontSize: 16,
    color: Colors.black54,
    ),
    ),
    const SizedBox(height: 8.0),

    // Quantity Control
    quantity == 0
    ? Container(
      width: double.maxFinite,
      child: ElevatedButton(
      onPressed: () {
      setState(() {
      selectedItems.add({
      'name': name,
      'price': price,
      'quantity': 1,
      });
      });
      },
      child: const Text('Pesan'),
      ),
    )
        : Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    IconButton(
    onPressed: () {
    setState(() {
    if (quantity == 1) {
    selectedItems.removeAt(itemIndex);
    } else {
    selectedItems[itemIndex]['quantity']--;
    }
    });
    },
    icon: const Icon(Icons.remove_circle,
    color: Colors.red),
    ),
    Text(
    '$quantity',
    style: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
      IconButton(
        onPressed: () {
          setState(() {
            selectedItems[itemIndex]['quantity']++;
          });
        },
        icon: const Icon(Icons.add_circle, color: Colors.green),
      ),
    ],
    ),
            ],
        ),
      );
        },
    );
  }
}
