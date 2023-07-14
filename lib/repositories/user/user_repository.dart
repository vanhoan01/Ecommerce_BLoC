import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_bloc/models/models.dart';

import 'base_user_repository.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseFirestore _firebaseFirestore;

  UserRepository({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .set(user.toDocument());
  }

  @override
  Stream<User> getUser(String userId) {
    // ignore: avoid_print
    print('Getting user data from Cloud Firestore');
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toDocument())
        .then(
          // ignore: avoid_print
          (value) => print('User document updated.'),
        );
  }
}
