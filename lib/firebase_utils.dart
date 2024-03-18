import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/model/my_user.dart';
import 'package:task_app/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }

  static Future<void> deleteTaskFromFireStore(Task task, String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static Future<void> addTaskToFirebase(Task task, String uId) {
    var taskCollectionRef = getTaskCollection(uId); // collection
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc(); // Document
    task.id = taskDocRef.id; // auto generate id
    return taskDocRef.set(task);
  }


  // static Future<bool> isdone(String uid, bool isDon) async {
  //   try {
  //     await getTaskCollection(uid).doc().update({'isDon': isDon});
  //     return true;
  //   } catch (e) {
  //     print(e);
  //     return true;
  //   }
  // }
static Future<void> updateTask(Task task,String uId){
 return getTaskCollection(uId).doc(task.id).update(task.toJson());
}
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFirestore(snapshot.data()),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  static Future<void> addUsersToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> querySnapShot =
        await getUsersCollection().doc(uId).get();
    return querySnapShot.data();
  }
}










  //  var docRef= FirebaseFirestore.instance
  //       .collection(Task.collectionName)
  //       .withConverter<Task>(
  //         fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
  //         toFirestore: (task, options) => task.toJson()).doc().set(task); // لو هدخل id بإيدي
  //        //لو محتاج اعمله اوتو جينرات
  //       //   task.id =docRef.id ;
  //       // docRef.set(task);
  // }

