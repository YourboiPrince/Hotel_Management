import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookedRooms;

  const CheckoutScreen({Key? key, required this.bookedRooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;

    // Calculate total price based on booked rooms
    for (final room in bookedRooms) {
      totalPrice += room['rate'] ?? 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) {
                final room = bookedRooms[index];
                return ListTile(
                  title: Text(room['type'] ?? ''),
                  subtitle: Text('Rate: ${room['rate'] ?? ''}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      // Remove the room from the booked rooms list
                      // You may need to implement this logic
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Proceed to M-Pesa payment
                _processMPesaPayment(context, totalPrice);
              },
              child: const Text('Proceed to M-Pesa Payment'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to process M-Pesa payment
  void _processMPesaPayment(BuildContext context, double totalPrice) {
    // Implement your M-Pesa payment logic here
    // This could involve calling an API to initiate the payment process
    // For demonstration purposes, let's just print a message
    print('Initiating M-Pesa payment for \$${totalPrice.toStringAsFixed(2)}');

    // Optionally, you can navigate to a success screen after payment completion
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PaymentSuccessScreen(),
    //   ),
    // );
  }
}
