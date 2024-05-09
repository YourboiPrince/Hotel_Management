import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hotels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
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

          return ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotelData = hotels[index].data();
              return ListTile(
              leading: Image.asset(
  (hotelData as Map<String, dynamic>)['imageUrl'] ?? 'assets/images/default_image.png',
  width: 80,
  height: 80,
  fit: BoxFit.cover,
),
title: Text(
  (hotelData as Map<String, dynamic>)['name'] ?? '',
),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Location: $hotelData'),
                    Text('Rating: $hotelData'),
                    // You can display more hotel information here
                  ],
                ),
                onTap: () {
                  // Navigate to room booking screen
               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomBookingScreen(hotelData: hotelData as Map<String, dynamic>),
                ),
              );

                },
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
                      // You can add code to book the room and update Firestore accordingly
                      // For demonstration purposes, I'm just showing a snackbar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Room booked: ${room['type']}'),
                        ),
                      );
                    },
                    child: Text('Book'),
                  )
                : Text('Not Available'),
          );
        },
      ),
    );
  }
}
