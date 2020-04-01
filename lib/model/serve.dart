
import 'package:aqueduct/aqueduct.dart';
class Serve extends ManagedObject<_Serve>   implements _Serve  {
      @override
  void read(Map<String, dynamic> object,{ Iterable<String> ignore,Iterable<String> reject ,Iterable<String> require  }) {
    print(object.toString());
    id = int.tryParse(object['id']?.elementAt(0).toString()) ;  
    name = object['name'].elementAt(0).toString().trim() ;
    gender = int.tryParse(object['gender'].elementAt(0).toString()) ;
   final String datestr = object['dob'].elementAt(0).toString().trim() ; 
    
    dob = DateTime.parse( datestr) ;    
    print(dob?.toIso8601String());
    familyId = Document(object['familyId'].elementAt(0)) ; 
    longitude = double.tryParse(object['longitude'].elementAt(0).toString())  ;
    latitude =double.tryParse(object ['latitude'].elementAt(0).toString()) ;  
  }

  @override
  Map<String, dynamic> asMap() {
    if(id==null)
       return {
      'name': name,
      'gender':gender,
        'dob':dob,
        'longitude':longitude,
        'latitude':latitude,
        'familyId': familyId
    };
    else
    return {
      'id': id,
      'name': name,
      'gender':gender,
        'dob':dob.toIso8601String(),
        'longitude':longitude,
        'latitude':latitude,
        'familyId': familyId.data.toString()
    };
  }
}

 class _Serve {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;

   @Column(unique: false)
  int gender;

   @Column(unique: false)
  DateTime dob;

   @Column(unique: false)
  double longitude;

   @Column(unique: false)
  double latitude;

  @Column(unique: false)
 Document familyId;

}
