import 'dart:convert';

import 'package:http/http.dart' as http;

class Networking {
  Future<Map<String, dynamic>> sendFriendRequest(
      String documentId, String userEmail, String userId) async {
    const url =
        'https://us-central1-chatbot-7a5a8.cloudfunctions.net/sendFriendRequest';
    try {
      var response = await http.post(
        url,
        body: {
          'DocumentId': documentId,
          'UserId': userId,
          'UserEmail': userEmail,
          'time': DateTime.now().toIso8601String(),
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> acceptFriendRequest(String userId, String userEmail,
      String friendId, String friendEmail, String deleteDocumentId) async {
    const url =
        'https://us-central1-chatbot-7a5a8.cloudfunctions.net/acceptFriendRequest';
    try {
      var response = await http.post(
        url,
        body: {
          'UserId': userId,
          'UserEmail': userEmail,
          'FriendUserEmail': friendEmail,
          'FriendUserId': friendId,
          'DeleteDocumentId': deleteDocumentId
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> sendMessage(String userId, String userEmail, String receiverId,
      String receiverEmail, String message) async {
    const url =
        'https://us-central1-chatbot-7a5a8.cloudfunctions.net/SendMessage';
    try {
      var response = await http.post(url, body: {
        'UserEmail': userEmail,
        'UserId': userId,
        'ReceiverId': receiverId,
        'ReceiverEmail': receiverEmail,
        'message': message,
        'time': DateTime.now().toIso8601String(),
      });
      if (response.statusCode == 200) {
        print(response.body.toString());
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteRequest(String userId, String documentId) async {
    const url =
        'https://us-central1-chatbot-7a5a8.cloudfunctions.net/deleteFriendRequest';
    try {
      var response = await http
          .post(url, body: {'UserId': userId, 'DocumentId': documentId});
      if (response.statusCode == 200) {
        print(response.body.toString());
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> addToken(var token, String userId) async {
    const url = 'https://us-central1-chatbot-7a5a8.cloudfunctions.net/AddToken';
    try {
      var response = await http.post(url, body: {
        'UserId': userId,
        'token': token,
        'date': DateTime.now().toIso8601String(),
      });
      if (response.statusCode == 200) {
        print(response.body.toString());
      }
    } catch (error) {
      print(error);
    }
  }
}
