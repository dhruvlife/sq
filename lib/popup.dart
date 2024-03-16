// import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _reviewController = TextEditingController();
  double overallRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate Your Experience',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                
                TextField(
                  controller: _reviewController,
                  decoration: InputDecoration(
                    hintText: 'Write your review here . . .',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  maxLength: 50,
                ),
                Row(
                  children: List.generate(5, (index) {
                    int rating = index + 1;
                    return IconButton(
                      icon: Icon(Icons.star,size: 40, color: Color.fromARGB(255, 17, 168, 255),),
                      onPressed: () {
                        _submitReview(rating.toDouble());
                      },
                    );
                  }),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Overall Rating: ${overallRating.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('user_reviews')
                  .orderBy('timestamp', descending: true)
                  .limit(20)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No reviews available'));
                }

                var totalRating = 0.0;
                for (var doc in snapshot.data!.docs) {
                  totalRating += doc['rating'];
                }
                overallRating = totalRating / snapshot.data!.docs.length;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Latest Reviews',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var review = snapshot.data!.docs[index];
                          return ListTile(
                            title: Text(review['email']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Rating: ${review['rating'].toString()}'),
                                Text('Review: ${review['review']}'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submitReview(double rating) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      // Handle user not authenticated
      return;
    }

    try {
      await _firestore.collection('user_reviews').doc(user.uid).set({
        'userId': user.uid,
        'email': user.email,
        'rating': rating,
        'timestamp': Timestamp.now(),
        'review': _reviewController.text,
      });

      // Show a snackbar to indicate that the review has been submitted
      Get.snackbar("Success", "Review Submitted",
          colorText: Colors.green, backgroundColor: Colors.black);
    } catch (e) {
      print('Error submitting review: $e');
      // Handle the error gracefully
      Get.snackbar("Error", "Failed to submit review",
          colorText: Colors.red, backgroundColor: Colors.black);
    }
  }
}
