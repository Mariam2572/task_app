// ignore_for_file: public_member_api_docs, sort_constructors_first
class MyUser {
  static const String collectionName ='User';
  String? id;
  String? name;
  String? email;
  MyUser({
    required this.id,
    required this.name,
    required this.email,
  });
  // json => object
 MyUser.fromFirestore(Map < String ,dynamic>? data):this(
  id: data?['id'],
  name: data?['name'],
  email:  data ?['email']

 );
  // object => json
Map <String ,dynamic> toFirestore() {
  return {
    'id': id,
    'name': name,
    'email': email
  };

}

  
}
