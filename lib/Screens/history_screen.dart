import 'package:flutter/material.dart';
import 'package:login_firebase_flutter/Component/generate_material_color.dart';
import 'package:login_firebase_flutter/Screens/home_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryUser extends StatefulWidget {



  HistoryUser({Key? key}) : super(key: key);

  @override
  _HistoryUser createState() => _HistoryUser();
}

class _HistoryUser extends State<HistoryUser>{

  @override
  Widget build(BuildContext context) {
    Widget _buildList(QuerySnapshot snapshot) {
      return ListView.builder(
        itemCount: snapshot.docs.length,
        itemBuilder: (context, index) {
          final doc = snapshot.docs[index];
          return ListTile(
            title: Text(doc["nama_resto"]),
            subtitle: Text(doc["jumlah"]),
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: generateMaterialColor(Colors.redAccent),
          title: Text("History"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }),
        ),
        body: ListView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("restaurants_booking")
                  .where("status", isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return SizedBox(
                  height: 300,
                  child: _buildList(snapshot.data!),
                );
              },
            )
          ],
        )
    );
  }
}
