import 'package:aqueduct/aqueduct.dart';
import 'package:project_serve/model/serve.dart';
import 'package:project_serve/project_serve.dart';

class ServeController extends ResourceController {
  ServeController(this.context ) {
    acceptedContentTypes = [ ContentType("application", "x-www-form-urlencoded"), ];
  }
  final ManagedContext context;
  // final _serves = [
  //   {'id': 11, 'name': 'Captain America'},
  //   {'id': 12, 'name': 'Ironman'},
  //   {'id': 13, 'name': 'Wonder Woman'},
  //   {'id': 14, 'name': 'Hulk'},
  //   {'id': 15, 'name': 'Black Widow'},
  // ];

  @Operation.post()
  Future<Response> createServe() async {
  final  Map<String,dynamic> map = await request.body.decode();
     final serve = Serve()..read(map, ignore:['id']);
    
    print(serve.name);
     final query = Query<Serve>(context)..valueMap= serve.asMap();

     final insertedServe = await query.insert();

    return Response.ok({"insertedServe":"${insertedServe.asMap().toString()}"});
  }

  @Operation.delete('id')
  Future<Response> deleteServeByID(@Bind.path('id') int id) async {
    final serveQuery = Query<Serve>(context)..where((h) => h.id).equalTo(id);
    final serve = await serveQuery.delete();
    if (serve == null) {
      return Response.notFound();
    }
    return Response.ok(serve);
  }

  @Operation.put('id')
  Future<Response> updateServeById(
      @Bind.path('id') int id, @Bind.body() Serve inputServe) async {
    final serveQuery = Query<Serve>(context)
      ..where((h) => h.id).equalTo(id)
      ..values = inputServe;
    final serve = await serveQuery.updateOne();
    if (serve == null) {
      return Response.notFound();
    }
    return Response.ok(serve);
  }

  @Operation.get()
  Future<Response> getAllServes() async {
    final serveQuery = Query<Serve>(context);
    final serves = await serveQuery.fetch();

    return Response.ok(serves);
  }

  @Operation.get('id')
  Future<Response> getServeByID(@Bind.path('id') int id) async {
    final serveQuery = Query<Serve>(context)..where((h) => h.id).equalTo(id);
    final serve = await serveQuery.fetchOne();
    if (serve == null) {
      return Response.notFound();
    }
    return Response.ok(serve);
  }
}

Map<String, dynamic> responseBetter(
        {bool status = false,
        String message = "Something Went Wrong",
        dynamic data}) =>
    {"status": status, "message": message, "data": data};
