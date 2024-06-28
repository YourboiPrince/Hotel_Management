import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatelessWidget {
  BookingsScreen({Key? key}) : super(key: key);

  String formatDate(String date) {
    
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var bookings = snapshot.data!.docs;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 10.0,
                columns: [
                  DataColumn(label: Text('Phone', style: TextStyle(fontSize: 12))),
                  DataColumn(label: Text('Check-in Date', style: TextStyle(fontSize: 12))),
                  DataColumn(label: Text('Check-out Date', style: TextStyle(fontSize: 12))),
                  DataColumn(label: Text('Total Price', style: TextStyle(fontSize: 12))),
                ],
                rows: bookings.map((booking) {
                  return DataRow(
                    cells: [
                      DataCell(Text(booking['phone'], style: TextStyle(fontSize: 12))),
                      DataCell(Text(formatDate(booking['checkInDate']), style: TextStyle(fontSize: 12))),
                      DataCell(Text(formatDate(booking['checkOutDate']), style: TextStyle(fontSize: 12))),
                      DataCell(Text('\$${booking['totalPrice']}', style: TextStyle(fontSize: 12))),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
