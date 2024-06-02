import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehety/features/auth/presentation/manager/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  //Login

  login({
    required email,
    required password,
  }) async {
    emit(LoginLoadingStat());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessStat());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginErrorStat(error: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginErrorStat(error: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginErrorStat(error: e.toString()));
    }
  }

  //Register A Doctor
  registerDoctor({
    required email,
    required password,
    required name,
  }) async {
    emit(RegisterLoadingStat());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);
      // store in firestore
      FirebaseFirestore.instance.collection('doctors').doc(user.uid).set({
        'name': name,
        'uid': user.uid,
        'image': '',
        'specializatioo': '',
        'rating': '',
        'phone1': '',
        'phone2': '',
        'email': email,
        'bio': '',
        'openHour': '',
        'closeHour': '',
        'address': '',
      }, SetOptions(merge: true));

      emit(RegisterSuccessStat());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorStat(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorStat(
            error: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterErrorStat(error: e.toString()));
    }
  }

  //Register A Patient
  registerPatient({
    required email,
    required password,
    required name,
  }) async {
    emit(RegisterLoadingStat());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = credential.user!;
      user.updateDisplayName(name);
      // store in firestore
      FirebaseFirestore.instance.collection('patients').doc(user.uid).set({
        'name': name,
        'uid': user.uid,
        'image': '',
        'age': '',
        'email': email,
        'phone': '',
        'bio': '',
        'city': '',
      }, SetOptions(merge: true));

      emit(RegisterSuccessStat());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorStat(error: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorStat(
            error: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterErrorStat(error: e.toString()));
    }
  }
  //Upload Doctor
}
