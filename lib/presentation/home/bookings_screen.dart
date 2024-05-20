import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          // Extract hotel data from snapshot
          final hotels = snapshot.data?.docs ?? [];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Three cards per row
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotelData = hotels[index].data() as Map<String, dynamic>;
              return Card(
                child: InkWell(
                  onTap: () {
                    // Navigate to room booking screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RoomBookingScreen(hotelData: hotelData),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          hotelData['imageUrl'] ?? 'assets/images/default_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotelData['name'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('Location: ${hotelData['location'] ?? ''}'),
                            Text('Rating: ${hotelData['rating'] ?? ''}'),
                          ],
                        ),
                      ),
                    ],
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

class RoomBookingScreen extends StatelessWidget {
  final Map<String, dynamic> hotelData;

  const RoomBookingScreen({Key? key, required this.hotelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rooms = hotelData['rooms'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Room Booking - ${hotelData['name']}'),
      ),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index] as Map<String, dynamic>; // Cast room to Map<String, dynamic>
          return ListTile(
            title: Text(room['type'] ?? ''),
            subtitle: Text('Rate: ${room['rate'] ?? ''}'),
            trailing: room['isAvailable'] == true
                ? ElevatedButton(
                    onPressed: () {
                      // Implement booking logic here
                      // For demonstration purposes, let's assume the room is successfully booked
                      final bookedRooms = [room]; // Add the booked room to the list
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(bookedRooms: bookedRooms),
                        ),
                      );
                    },
                    child: const Text('Book'),
                  )
                : const Text('Not Available'),
          );
        },
      ),
    );
  }
}

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
              physics: NeverScrollableScrollPhysics(),
              itemCount: bookedRooms.length,
              itemBuilder: (context, index) {
                final room = bookedRooms[index];
                return ListTile(
                  title: Text(room['type'] ?? ''),
                  subtitle: Text('Rate: ${room['rate'] ?? ''}'),
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Navigate back to the previous screen
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
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
