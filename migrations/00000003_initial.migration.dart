import 'dart:async';

import 'package:aqueduct/aqueduct.dart';   

class Migration1 extends Migration { 
  @override
  Future upgrade() async {
   database.createTable(SchemaTable("_Serve", [
SchemaColumn("id", ManagedPropertyType.bigInteger, isPrimaryKey: true, autoincrement: true, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("name", ManagedPropertyType.string, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("gender", ManagedPropertyType.integer, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("familyId", ManagedPropertyType.document, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("latitude", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("longitude", ManagedPropertyType.doublePrecision, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
SchemaColumn("dob", ManagedPropertyType.datetime, isPrimaryKey: false, autoincrement: false, isIndexed: false, isNullable: false, isUnique: false),
],
));


  }
  
  @override
  Future downgrade() async {}
  
  @override
Future seed() async {
  final heroNames = ["Mr. Nice", "Narco", "Bombasto", "Celeritas", "Magneta"];

  for (final heroName in heroNames) {    
    await database.store.execute("INSERT INTO _Serve (name,gender,familyId,latitude,longitude,dob) VALUES (@name,@gender,@familyId,@latitude,@longitude,@dob )", substitutionValues: {
      "name": heroName,
      "gender":0,
      "familyId":{ "primary_family":null},  
      "latitude":77.8,
      "longitude":22.9,
      "dob":DateTime(1998,10,11)
    });
  }
}
}