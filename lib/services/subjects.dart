import 'package:cloud_firestore/cloud_firestore.dart';

Subjects _$SubjectsFromJson(Map<String, dynamic> json) {
      return Subjects(
      )..id = json['id'] as String;
}
 Map<String, dynamic> _$SubjectsToJson(Subjects instance) => <String, dynamic>{
          'id': instance.id,
};
class Subjects {
    String id;
    Subjects();

    Stream<List<Subjects>> subjectsList() {
      var ref = Firestore.instance.collection('subjects');
      return ref.snapshots().map((list) => list.documents.map((doc) => Subjects.fromFirestore(doc)).toList());
    }
        
    factory Subjects.fromJson(Map<String, dynamic> json) => _$SubjectsFromJson(json);

    Map<dynamic, dynamic> toJson() => _$SubjectsToJson(this);

    factory Subjects.fromFirestore(DocumentSnapshot documentSnapshot) {
      Subjects sub = Subjects.fromJson(documentSnapshot.data);
      sub.id = documentSnapshot.documentID;
      return sub;
  }
}