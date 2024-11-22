import 'package:flutter/material.dart';
import 'package:tastygo/Constant/Colors.dart';

class InvoicePage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;
  final int totalPrice;

  const InvoicePage({
    Key? key,
    required this.selectedItems,
    required this.totalPrice,
  }) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String selectedPaymentMethod = 'Cash'; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice',style: TextStyle(color: Colors.white),),
        backgroundColor: PrimaryColors(),
        iconTheme: const IconThemeData(color: Colors.white), // Set the back icon color to white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Pesanan Anda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),

            // List of items
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: widget.selectedItems.length,
                itemBuilder: (context, index) {
                  final item = widget.selectedItems[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text(
                        'Rp ${item['price']} x ${item['quantity']} = Rp ${int.parse(item['price'].replaceAll(',', '')) * item['quantity']}'),
                  );
                },
              ),
            ),
            const Divider(),

            // Total Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${widget.totalPrice}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Payment Method
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),

            // Payment Method Grid
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 2, // Two columns
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.5,
                children: [
                  paymentCard(
                    'Cash',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxVK2Ldio3wbcompe76GCOvyURqeR96FG-Ow&s',
                  ),
                  paymentCard(
                    'GoPay',
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/GoPay_Logo.svg/1024px-GoPay_Logo.svg.png',
                  ),
                  paymentCard(
                    'ShopeePay',
                    'https://lapakngapak.com/asset/foto_produk/ln-shopee_pay.png',
                  ),
                  paymentCard(
                    'DANA',
                    'https://cdn-icons-png.flaticon.com/512/4131/4131469.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),

            // Confirm Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Pembayaran Berhasil'),
                      content: Text(
                          'Anda telah membayar dengan metode $selectedPaymentMethod.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.pop(context); // Back to previous page
                          },
                          child: const Text('OK'),
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
                  'Konfirmasi Pembayaran',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Payment Card Widget
  Widget paymentCard(String method, String iconUrl) {
    final isSelected = selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Card(
        elevation: 4,
        color: isSelected ? Colors.teal[50] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: isSelected
              ? const BorderSide(color: Colors.teal, width: 2)
              : BorderSide.none,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.network(
              //   iconUrl,
              //   width: 50,
              //   height: 50,
              //   fit: BoxFit.contain,
              // ),
              // const SizedBox(height: 8.0),
              Text(
                method,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.teal : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
