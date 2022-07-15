import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CommonService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> get terms async {
    String content = '';
    DocumentReference documentReference =
        _firebaseFirestore.collection('common').doc('terms');
    content = (await documentReference.get()).get("content");
    return content.replaceAll('\\n', "\n");
  }
}
