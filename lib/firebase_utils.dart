import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_app/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, options) => task.toJson(),
        );
  }
static void updateTask(Task task){
  getTaskCollection().doc(task.id).update
  ({'title' : task.title ,'description': task.description,'dateTime' :task.dateTime });
}
 static Future<void>  deleteTaskFromFireStore(Task task){
return  getTaskCollection().doc(task.id).delete();
 }
//  static void editTaskFromFireStore(Task task){
//   getTaskCollection().doc(task.id).update(data)
//  }
  static Future<void> addTaskToFirebase(Task task) {
    var taskCollectionRef = getTaskCollection(); // collection
    DocumentReference<Task> taskDocRef = taskCollectionRef.doc();  // Document
    task.id = taskDocRef.id;  // auto generate id
     return taskDocRef.set(task);

  
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

