 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<String> signinscreen(String e1,String p1)
 async{
   try {
     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
     await firebaseAuth.createUserWithEmailAndPassword(email: e1, password: p1);
     return 'Success';
   } on FirebaseAuthException catch (e) {
     if (e.code == 'weak-password') {
       print('Password at least 6 character');
       return "Password at least 6 character";
     } else if (e.code == 'email-already-in-use') {
       print('The account already exists for that email.');
       return "The account already exists for that email.";

     }
   } catch (e) {
     print(e);
   }

    return '';
 }

 Future<String> loginscreenn(String e1,String p1)
 async{
   try {
     FirebaseAuth firebaseAuth = FirebaseAuth.instance;
     await firebaseAuth.signInWithEmailAndPassword(email: e1, password: p1);
     return 'Success';
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
       return 'No user found for that email.';
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
       return 'Wrong password provided for that user.';
     }
   }
   catch (e) {
     print(e);
   }
   return '';
 }


 Future<String> mobilecheck(String mob,String sms)
 async{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   await firebaseAuth.verifyPhoneNumber(
     phoneNumber: mob,        /*'${mob}'*/
     verificationCompleted: (PhoneAuthCredential credential) async{
       await firebaseAuth.signInWithCredential(credential);
     },
     verificationFailed: (FirebaseAuthException e){
       if (e.code == 'invalid-phone-number') {
         print('The provided phone number is not valid.');
       }
     },
     codeSent: (String verificationId, int? resendToken) async{

       PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: sms);

       await firebaseAuth.signInWithCredential(credential);
     },
     codeAutoRetrievalTimeout: (String verificationId) {},
   );
   return '';
 }

 bool checkUser()
 {
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null)
      {
        return true;
      }
    return false;
 }

 void logouts()
 {
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   firebaseAuth.signOut();
 }


 Future<bool> signInWithGoogle() async {

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleSignInAccount!.authentication;

   var credential = GoogleAuthProvider.credential(
     accessToken: googleAuth.accessToken,
     idToken: googleAuth.idToken,
   );

    await FirebaseAuth.instance.signInWithCredential(credential);

    return checkUser();
 }

 Future<List> Userprofile()
 async{
   User? user = await FirebaseAuth.instance.currentUser;
   return [
     user!.email,
     user.displayName,
     user.photoURL
   ];
 }

 void insertdata(String id,String name,String mobile,String std)
 {
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   CollectionReference collectionReference = firebaseFirestore.collection("Student");
   collectionReference.add({"id": id,"name": name,"mobile": mobile,"std": std,})
   .then((value) => print("Success")).catchError((error)=> print('$error'));
 }

 Stream<QuerySnapshot<Map<String, dynamic>>> readdata()
 {
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   return firebaseFirestore.collection("Student").snapshots();
 }

 void deletedata(String key)
 {
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   firebaseFirestore.collection("Student").doc("$key").delete();
 }

 void updatedata(String key,String id,String name,String mob,String std)
 {
   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   firebaseFirestore.collection("Student").doc("$key").set({
     "id": id,"name": name,"mobile": mob,"std": std,
   });
 }






















