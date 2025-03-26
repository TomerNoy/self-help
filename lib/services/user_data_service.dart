import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:self_help/models/exercise_result.dart';
import 'package:self_help/models/result.dart';
import 'package:self_help/models/stress_track.dart';

class UserDataService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //TODO: Implement
  Future<Result<void>> addStressTrack(StressTrack track) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.failure('User not logged in');
      }

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('stressTracks')
          .doc();

      await docRef.set(track.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  //TODO: Implement
  Future<Result<List<StressTrack>>> getStressTracks() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.failure('User not logged in');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('stressTracks')
          .get();

      final tracks =
          snapshot.docs.map((doc) => StressTrack.fromJson(doc.data())).toList();

      return Result.success(tracks);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  //TODO: Implement
  Future<Result<void>> addExerciseResult(ExerciseResult exercise) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.failure('User not logged in');
      }

      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('exerciseResults')
          .doc();

      await docRef.set(exercise.toJson());
      return Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  //TODO: Implement
  Future<Result<List<ExerciseResult>>> getExerciseResults() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return Result.failure('User not logged in');
      }

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('exerciseResults')
          .get();

      final exercises = snapshot.docs
          .map((doc) => ExerciseResult.fromJson(doc.data()))
          .toList();

      return Result.success(exercises);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
