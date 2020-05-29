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