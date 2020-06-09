import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_storage/widget/inputEmail.dart';

class User {
    final String uid, uname;
    User({ this.uid, this.uname});
}

class AuthServ {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User createFBaseUser(FirebaseUser usr) {
        return usr!=null? User(uid: usr.uid, uname: usr.email+'\b\b\b\b\b\b\b\b\b\b') : null;   
    }

    // user auth change stream
    Stream</*FirebaseUser*/User> get usr {
        return  _auth.onAuthStateChanged.map((FirebaseUser user) => createFBaseUser(user)); //or just .map(createFBaseUser);
    }

    //sign in anonymously
    Future signInAnon() async {
        try {
          AuthResult rslt = await _auth.signInAnonymously();
          FirebaseUser user = rslt.user;
          return createFBaseUser(user);
        } 
        catch(error) {
          print(error.toString());
          return null;
        }
    }

    //sign in email pwd
    Future singInEmailPwd(String email, String pswd) async {
      try {
          AuthResult rslt = await _auth.signInWithEmailAndPassword(email: email, password: pswd);
          FirebaseUser user = rslt.user;
          return createFBaseUser(user);
      }
      catch(error) {
          print(error.toString());
          return null;
      }
    }

    //sign up email pwd
    Future regEmailPwd(String email, String pswd) async {
      try {
          AuthResult rslt = await _auth.createUserWithEmailAndPassword(email: email, password: pswd);
          FirebaseUser user = rslt.user;
          return createFBaseUser(user);
      }
      catch(error) {
          print(error.toString());
          return null;
      }
    }

    //signout
    Future singOut() async {
      try {
        return await _auth.signOut();
      }
      catch(error) {
        print(error.toString());
        return null;
      }
    }
}

Uploaders _$UploadersFromJson(Map<String, dynamic> json) {
      return Uploaders(
        json['name'] as String,
      )..id = json['id'] as String;
}
 Map<String, dynamic> _$UploadersToJson(Uploaders instance) => <String, dynamic>{
          'id': instance.id,
          'name': instance.name,
};

class Uploaders {
    String id, name;

    Uploaders(this.name);

    Stream<List<Uploaders>> streamOfUsers() {
      var ref = Firestore.instance.collection('uploaders');
      return ref.snapshots().map((list) => list.documents.map((doc) => Uploaders.fromFirestore(doc)).toList());
    }
        
    factory Uploaders.fromJson(Map<String, dynamic> json) => _$UploadersFromJson(json);

    Map<dynamic, dynamic> toJson() => _$UploadersToJson(this);

    factory Uploaders.fromFirestore(DocumentSnapshot documentSnapshot) {
      Uploaders user = Uploaders.fromJson(documentSnapshot.data);
      user.id = documentSnapshot.documentID;
      return user;
  }
}